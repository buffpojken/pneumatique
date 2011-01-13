require 'pneumatique'
use Rack::Session::Cookie
use Rack::Flash, :accessorize => [:notice, :error]
run Sinatra::Application