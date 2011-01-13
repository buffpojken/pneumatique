require 'rubygems'
require 'sinatra'
require 'rack/flash'
require 'active_record'

set :root, File.dirname(__FILE__)

use Rack::Session::Cookie
use Rack::Flash

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'pneumatique.sqlite3.db'
)

class Email < ActiveRecord::Base
  
end

get '/' do 
  @rand = rand(3)
  erb :index
end


post '/email' do 
  puts params.inspect
  email = Email.new(:email => params["email"])
  if email.save && email.errors.empty? 
    flash[:notice] = "Email added. Thanks!"
  else
    flash[:error] = "Could not add your email? Try again!"
  end
  redirect '/'
end