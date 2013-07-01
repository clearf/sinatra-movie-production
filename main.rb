require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?


def run_sql(sql)
	db = PG.connect(dbname: 'production', host: 'localhost')
	result = db.exec(sql)
	db.close
	result
end


get '/' do

end

get '/tasks' do
	sql = "SELECT * FROM tasks"
	@tasks = run_sql(sql)
	erb :todos
end
