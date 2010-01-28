module Mephisto
  module Liquid
    class LoginForm < ::Liquid::Block

      def render(context)
        result = []
        
        context.stack do

          if context['message'].blank? 
            errors = context['errors'].blank? ? '' : %Q{<ul id="login-errors"><li>#{context['errors'].join('</li><li>')}</li></ul>}

            submitted = context['submitted'] || {}
            submitted.each{ |k, v| submitted[k] = CGI::escapeHTML(v) }
            
            context['form'] = {
              'uname'   => %(<input type="text" id="login_uname" name="login[uname]" value="#{submitted['uname']}" />),
              'pword'   => %(<input type="password" id="login_pword" name="login[pword]" value="#{submitted['pword']}" />),
              'submit' => %(<input type="submit" value="Login" />)
            }
            
            result << %(<form id="login-form" method="post" action="/check">#{[errors]+render_all(@nodelist, context)}</form>)
          else
            result << %(<p id="login-message">#{context['message']}</p>)
          end
        end
        result
      end
    end
  end
end

