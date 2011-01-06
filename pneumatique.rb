require 'rubygems'
require 'sinatra'

set :public, 'public'

get '/' do 
  @rand = rand(3)
  erb :index
end