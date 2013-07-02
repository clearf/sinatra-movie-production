require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'imdb'

#################### DEFINE METHODS ####################
def run_sql(sql)
  db = PG.connect(:dbname => 'movie_todo_hw', :host => 'localhost')
  result = db.exec(sql)
  db.close
  return result
end

# METHOD TO FETCH IBMD DATA AND SAVE INTOT HE DATABASE
def download_movie(title)
  # DOWNLOAD AND ASSIGN DATA TO VARIABLES
  movie_data = Imdb::Search.new(title).movies.first

  title = movie_data.title
  year = movie_data.year
  company = movie_data.company
  genres = movie_data.genres.join(", ").to_s
  length = movie_data.length
  director = movie_data.director
  mpaa_rating = movie_data.mpaa_rating
  poster = movie_data.poster

  # SAVE THE ASSIGNED VARIABLE INTO DATABASE
  sql_add_movie = "INSERT INTO movies (title, year, company, genres, length, director, mpaa_rating, poster) VALUES
    ('#{title}', '#{year}', '#{company}', '#{genres}', '#{length}', '#{director}', '#{mpaa_rating}', '#{poster}')"
  run_sql(sql_add_movie)
end


#################### MAIN LANDING PAGE ####################
get '/' do

  sql_get_movies = "SELECT * FROM movies"
  @got_movies = run_sql(sql_get_movies)

  sql_get_people = "SELECT * FROM people"
  @got_people = run_sql(sql_get_people)

  sql_get_todos = "SELECT * FROM tasks"
  @got_todos = run_sql(sql_get_todos)

  erb :index
end


#################### MOVIE SECTION ####################
get '/movies' do
  sql_get_movies = "SELECT * FROM movies"
  @got_movies = run_sql(sql_get_movies)
  erb :movies
end

# HERE THE USER INPUT A NEW MOVIE
get '/movies/new' do
  erb :new_movie
end

post '/movies/new' do
  title = params[:title]
  download_movie(title)

  sql_get_movies = "SELECT * FROM movies"
  added_movie_index = run_sql(sql_get_movies).count - 1
  added_movie_id = run_sql(sql_get_movies)[added_movie_index]['id']

  redirect to("/movies/#{added_movie_id}")
end



#################### PEOPLE SECTION ####################
# SHOW ALL PEOPLE WORKING
get '/people' do
  sql_get_people = "SELECT * FROM people"
  @got_people = run_sql(sql_get_people)
  erb :people
end

# HERE USER CAN ADD A NEW PERSON
get '/people/new' do
  erb :new_person
end

# ADD A NEW PERSON TO DATABASE AND REDIRECT
post '/people/new' do
  name = params[:name]
  title = params[:title]
  phone = params[:phone]
  idiot = params[:idiot]

  sql_add_person = "INSERT INTO people (name, title, phone, idiot) VALUES ('#{name}', '#{title}', '#{phone}', '#{idiot}')"
  run_sql(sql_add_person)

  redirect to('/people')
end

# HERE USER CAN EDIT A NEW PERSON
get '/people/edit/:id' do
  id = params[:id]
  sql_get_person = "SELECT * FROM people WHERE id = #{id}"
  @got_person = run_sql(sql_get_person)

  erb :edit_person
end

# EDIT THE DATABASE AND REDIRECT
post '/people/edit/:id' do
  id = params[:id]
  name = params[:name]
  title = params[:title]
  phone = params[:phone]
  idiot = params[:idiot]

  sql_edit_person = "UPDATE people SET (name, title, phone, idiot) = ('#{name}', '#{title}', '#{phone}', '#{idiot}') WHERE id = #{id}"
  run_sql(sql_edit_person)

  redirect to("/people/#{id}")
end

# HERE USER CAN DELETE A PERSON
  post '/people/delete/:id' do
  id = params[:id]

  sql_delete_person = "DELETE FROM people WHERE id = #{id}"
  run_sql(sql_delete_person)

  redirect to('/people')
end

# SHOW DETAILS OF EACH INDIVIDUAL
get '/people/:id' do
  id = params[:id]
  sql_get_person = "SELECT * FROM people WHERE id = #{id}"
  @got_person = run_sql(sql_get_person)
  erb :person
end

#################### TODO SECTION ####################
# SHOW ALL TASKS
get '/todos' do
  sql_get_todos = "SELECT * FROM tasks"
  @got_todos = run_sql(sql_get_todos)
  erb :todos
end

get '/todos' do
  erb :todos
end

# HERE USER CAN ADD A NEW TASKS
get '/todos/new' do
  erb :new_todo
end

post '/todos/new' do
  # name = params[:name].capitalize
  # title = params[:title].capitalize
  # phone = params[:phone]
  # idiot = params[:idiot]

  # sql_add_person = "INSERT INTO people (name, title, phone, idiot) VALUES ('#{name}', '#{title}', '#{phone}', '#{idiot}')"
  # run_sql(sql_add_person)

  # redirect to('/people')
end

# SHOW DETAILS OF EACH TASK
get '/todos/:id' do
  id = params[:id]
  sql_get_todo = "SELECT * FROM tasks WHERE id = #{id}"
  @got_todo = run_sql(sql_get_todo)
  erb :todo
end




