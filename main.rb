require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

# helper function that runs an input sql string
def run_sql(sql)
	db = PG.connect(dbname: 'production', host: 'localhost')
	result = db.exec(sql)
	db.close
	result
end

get '/' do

end

# lists all of the tasks that require completion
get '/todos' do
	sql = "SELECT * FROM tasks"
	@todos = run_sql(sql)
	erb :todos
end

# adds a new todo to the lists of tasks to be done
post '/todos' do 
	urgent = params[:urgent]
	if urgent.nil?
		urgent = false
	else 
		urgent = true
	end
	sql = "INSERT INTO tasks (task, details, due, urgent, person_id, movie_id)"\
	" VALUES ('#{params[:task]}', '#{params[:details]}', '#{params[:due]}', "\
	" '#{urgent}', #{params[:person_id]}, #{params[:movie_id]})"
	run_sql(sql)
	redirect to('/todos')
end

# gets the necessary data to create a new task item (people and movies)
get '/todos/new' do
	movies_sql = "SELECT * FROM movies" 
	people_sql = "SELECT * FROM people"
	@movies = run_sql(movies_sql)
	@people = run_sql(people_sql)
	erb :new_todo
end

# shows the details of a task
get '/todos/:id' do
	sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
	@todo = run_sql(sql).first
	person_sql = "SELECT * FROM people WHERE id = #{@todo['person_id']}"
	movie_sql = "SELECT * FROM movies WHERE id = #{@todo['movie_id']}"
	@person = run_sql(person_sql).first
	@movie = run_sql(movie_sql).first
	erb :todo 
end

# updates the details of a task
post '/todos/:id' do 
	urgent = params[:urgent]
	if urgent.nil?
		urgent = false
	else 
		urgent = true
	end
		sql = "UPDATE tasks SET (task, details, due, urgent, person_id, movie_id)"\
	" = ('#{params[:task]}', '#{params[:details]}', '#{params[:due]}', "\
	" '#{urgent}', #{params[:person_id]}, #{params[:movie_id]}) WHERE id = "\
	" #{params[:id]}"
	run_sql(sql)
	redirect to('/todos')
end

# retrieves the necessary data to update a task (people, movies, task details)
get '/todos/:id/edit' do 
	sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
	movies_sql = "SELECT * FROM movies" 
	people_sql = "SELECT * FROM people"
	@todo = run_sql(sql).first
	@movies = run_sql(movies_sql)
	@people = run_sql(people_sql)
	current_person_sql = "SELECT * from people WHERE id = #{@todo['person_id']}"
	current_movie_sql = "SELECT * FROM people WHERE id = #{@todo['movie_id']}"
	@current_person = run_sql(current_person_sql).first
	@current_movie = run_sql(current_movie_sql).first
	erb :edit_todo
end

# deletes a task
get '/todos/:id/delete' do
	sql = "DELETE FROM tasks WHERE id = #{params[:id]}"
	run_sql(sql)
	redirect to('/todos')
end

#################### End Task Specific Routes #########################

# lists all of the movies currently listed as in production
get '/movies' do 
	sql = "SELECT * FROM movies WHERE id != 1"
	@movies = run_sql(sql)
	erb :movies
end

post '/movies' do
	sql = "INSERT INTO movies (title, description, director_id) VALUES "\
	"('#{params[:title]}', '#{params[:description]}', #{params[:director_id]})"
	run_sql(sql)
	redirect to('/movies')
end

# adds a new movie to the movies in production
get '/movies/new' do
	people_sql = "SELECT * FROM people"
	@people = run_sql(people_sql)
	erb :new_movie
end


get '/movies/:id' do 
	sql = "SELECT * FROM movies WHERE id = #{params[:id]}"
	@movie = run_sql(sql).first
	director_sql = "SELECT * FROM movies WHERE id = #{@movie["director_id"]}"
	@director = run_sql(director_sql).first
	tasks_sql = "SELECT * FROM tasks WHERE movie_id = #{@moive["id"]}"
	@todos = run_sql(tasks_sql)
	erb :movie
end





