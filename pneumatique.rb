require 'rubygems'
require 'active_record'
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
  @rand = rand(16)
  erb :index
end

get '/en' do 
  @rand = rand(16)
  erb :en_index
end

get '/download' do
	erb :download_index
end

get '/club-event' do
	erb :club_event
end

get '/laserdisko-event' do
	erb :laserdisko_event
end

get '/alternight-event' do
	erb :alternight_event
end

get '/adrenalin-event' do
	erb :adrenalin_event
end

get '/adrenalin-club' do
	erb :adrenalin_club
end

get '/alternight-club' do
	erb :alternight_club
end

get '/laserdisko-club' do
	erb :laserdisko_club
end

get '/pe-club' do
	erb :pe_club
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