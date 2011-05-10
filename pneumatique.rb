require 'rubygems'
require 'activerecord'
require 'sinatra'
require 'rack-flash'

set :root, File.dirname(__FILE__)
set :public, File.dirname(__FILE__)+"/public"

use Rack::Session::Cookie
use Rack::Flash

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'pneumatique.sqlite3.db'
)

class Email < ActiveRecord::Base
  
end

get '/' do 
  @rand = rand(15)
  erb :index
end

get '/en' do 
  @rand = rand(15)
  erb :en_index
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