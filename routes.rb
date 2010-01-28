map.login 	"login", 	:controller => "userlogin", :action => "login"
map.check	"check",	:controller => "userlogin", :action => "check"
map.logout 	"logout", 	:controller => "userlogin", :action => "logout"

map.protected '/protected',	:controller => "userlogin", :action => "index"
map.connect 'protected/:page',	:controller => "userlogin", :action => "show", :page => /.*/

