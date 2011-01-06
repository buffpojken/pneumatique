require 'rubygems'
require 'sinatra'

set :root, File.dirname(__FILE__)
set :public, 'public'

get '/' do 
  @rand = rand(3)
  erb :index
end