class UserloginController < ApplicationController
  unloadable

  def login
    render_liquid_template_for(:login_form, :status => "200 OK")
  end

  def check
    login = params[:login]
    @userlogin = ::Userlogin.find(:first, :conditions => [ "login = ?", login[:uname]])
    if @userlogin
      if @userlogin.password == login[:pword]
        cookies[:userlogin] = { :value => login[:uname], :expires => 1.hour.from_now }
        redirect_to "/protected"
      else
        render_liquid_template_for(:login_form, :status => "200 OK")
      end
    else
      render_liquid_template_for(:login_form, :status => "200 OK")
    end
  end

  def logout
    unless cookies[:userlogin].blank?
      cookies.delete :userlogin
      redirect_to "/"
    end
  end

  def index
    # Show a page with infos and logout link
    unless cookies[:userlogin].blank?
      @user = ::Userlogin.find(:first, :conditions => [ "login = ?", cookies[:userlogin]])
      unless @user.blank?
        render_liquid_template_for(:protected_index, 'user' => @user)
      else
        # No userlogin for the given cookie value found, redirect to login page
        redirect_to "/login"
      end      
    else
      # If the userlogin cookie is blank, redirect to the login page
      redirect_to "/login"
    end
  end

  def show
    # Handle individual page requests
    @page = params[:page]

    unless cookies[:userlogin].blank?
      @user = ::Userlogin.find(:first, :conditions => [ "login = ?", cookies[:userlogin]])
      unless @user.blank?
        if @page.blank?
          # Someone called /protected/
          redirect_to "/protected"
        elsif @user.sites.split(',').map{|s| s.strip }.include?(@page)
          # Someone called a page and has the right to see it
          render_liquid_template_for("#{@page}", :status => "200 OK")
        else
          # The given userlogin is not allowed to see this page
          redirect_to "/login"
        end
      else
        # No userlogin for the given cookie value found, redirect to login page
        redirect_to "/login"
      end
    else
      # If the userlogin cookie is blank, redirect to the login page
      redirect_to "/login"
    end

  end
end

