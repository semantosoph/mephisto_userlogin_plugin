module Admin
  class UserloginController < Admin::BaseController
      
    def index
      # List all user logins
      @userlogins = ::Userlogin.find(:all, :order => "login ASC")
    end
    
    def new
      # Prepare a new user login
      @userlogin = Userlogin.new
    end
    
    def create
      # Create a new persistent user login
      @userlogin = Userlogin.new(params[:userlogin])
      @userlogin.save
      if @userlogin.errors.empty?
        flash[:notice] = "Userlogin successfully created"
        redirect_to :action => 'index'
      else
        flash[:error] = @userlogin.errors.full_messages.first
        render :action => 'new'
      end
    end
  
    def destroy
      # Remove a user login from the database
      @userlogin = Userlogin.find(params[:id])
      if @userlogin.destroy
        flash[:notice] = 'Userlogin was successfully removed'
      else
        flash[:error] = 'Userlogin could not be removed'
      end
      redirect_to :action => 'index'
    end
    
    def edit
      # Action for editing a user login
      @userlogin = Userlogin.find(params[:id])
    end
    
    def update
      # Save edited user login data

      @userlogin = Userlogin.find(params[:id])
      if @userlogin.update_attributes(params[:userlogin])
        flash[:notice] = "Userlogin successfully updates"
        redirect_to :action => 'index'
      else
        flash[:error] = 'Userlogin could not be updated'
        render :action => 'edit', :id => params[:id]
      end
    end

  end
end
