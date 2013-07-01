require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

get '/' do
  erb :index
end

get '/movies' do
  erb :movies
end