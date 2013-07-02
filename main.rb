require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?


get '/new_todo'  do
	@people = [ 
		{name: "John", id:1},
		{name: "Bob", id:2},
		{name: "Jane", id:3}
	]
	# If we were working from the DB
	# We would be returning the results of our query
	# @people = sql_exec("select * from people")
	erb :new_todo
end

post '/new_todo'  do
	"#{params[:Name]} made choice #{params[:my_choice]}"
end