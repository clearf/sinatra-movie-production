require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

def run_sql(sql)
  db = PG.connect(:dbname => 'movie_todo_hw', :host => 'localhost')
  result = db.exec(sql)
  db.close
  return result
end

get '/' do
end



