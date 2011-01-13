require 'pneumatique'
use Rack::Flash, :accessorize => [:notice, :error]
run Sinatra::Application