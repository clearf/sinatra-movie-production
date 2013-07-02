require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'imdb'

#################### DEFINE METHODS ####################
# METHOD TO ACCESS PSQL DATABASE WITH A GIVEN COMMAND
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
  director = movie_data.director.join
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

# HERE USER CAN EDIT THE MOVIE INFO
get '/movies/edit/:id' do
  id = params[:id]
  sql_get_movie = "SELECT * FROM movies WHERE id = #{id}"
  @got_movie = run_sql(sql_get_movie)

  erb :edit_movie
end

# EDIT THE DATABASE AND REDIRECT
post '/movies/edit/:id' do
  id = params[:id]
  title = params[:title]
  year = params[:year]
  company = params[:company]
  genres = params[:genres]
  length = params[:length]
  director = params[:director]
  mpaa_rating = params[:mpaa_rating]
  poster = params[:poster]

  sql_edit_movie = "UPDATE movies SET (title, year, company, genres, length, director, mpaa_rating, poster) =
    ('#{title}', '#{year}', '#{company}', '#{genres}', '#{length}', '#{director}', '#{mpaa_rating}', '#{poster}')
    WHERE id = #{id}"
  run_sql(sql_edit_movie)

  redirect to("/movies/#{id}")
end

# HERE USER CAN DELETE A PERSON
post '/movies/delete/:id' do
  id = params[:id]

  sql_delete_movie = "DELETE FROM movies WHERE id = #{id}"
  run_sql(sql_delete_movie)

  redirect to('/movies')
end

# SHOW DETAILS OF EACH MOVIE
get '/movies/:id' do
  id = params[:id]
  sql_get_movie = "SELECT * FROM movies WHERE id = #{id}"
  @got_movie = run_sql(sql_get_movie)
  erb :movie
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

  #LOAD OTHER TABLES FOR SECONDARY INFO
  sql_get_people = "SELECT * FROM people"
  @got_people = run_sql(sql_get_people)


  sql_get_todos = "SELECT * FROM tasks"
  @got_todos = run_sql(sql_get_todos)

  erb :todos
end

# HERE USER CAN ADD A NEW TASKS
get '/todos/new' do
  sql_get_movies = "SELECT * FROM movies"
  @got_movies = run_sql(sql_get_movies)

  sql_get_people = "SELECT * FROM people"
  @got_people = run_sql(sql_get_people)

  erb :new_todo
end

post '/todos/new' do
  todo = params[:todo].capitalize
  note = params[:note].capitalize
  assigned_to = params[:assigned_to]
  related_to = params[:related_to]

  sql_add_todo = "INSERT INTO tasks (todo, note, status, assigned_to, related_to)
    VALUES ('#{todo}', '#{note}', 'false', '#{assigned_to}', '#{related_to}')"
  run_sql(sql_add_todo)

  redirect to('/todos')
end

# HERE USER CAN EDIT A NEW TESK
get '/todos/edit/:id' do
  id = params[:id]
  sql_get_todo = "SELECT * FROM tasks WHERE id = #{id}"
  @got_todo = run_sql(sql_get_todo)

  sql_get_movies = "SELECT * FROM movies"
  @got_movies = run_sql(sql_get_movies)

  sql_get_people = "SELECT * FROM people"
  @got_people = run_sql(sql_get_people)

  erb :edit_todo
end

# EDIT THE DATABASE AND REDIRECT
post '/todos/edit/:id' do
  id = params[:id]
  todo = params[:todo].capitalize
  note = params[:note].capitalize
  status = params[:status]
  assigned_to = params[:assigned_to]
  related_to = params[:related_to]

  sql_edit_todo = "UPDATE tasks SET (todo, note, status, assigned_to, related_to) = ('#{todo}', '#{note}', '#{status}', '#{assigned_to}', '#{related_to}') WHERE id = #{id}"
  run_sql(sql_edit_todo)

  redirect to("/todos/#{id}")
end

# HERE USER CAN DELETE A TASK
  post '/todos/delete/:id' do
  id = params[:id]

  sql_delete_todo = "DELETE FROM tasks WHERE id = #{id}"
  run_sql(sql_delete_todo)

  redirect to('/todos')
end

# SHOW DETAILS OF EACH TASK
get '/todos/:id' do
  id = params[:id]
  sql_get_todo = "SELECT * FROM tasks WHERE id = #{id}"
  @got_todo = run_sql(sql_get_todo)

  assignee_id = @got_todo.first['assigned_to']
  sql_get_person = "SELECT * FROM people WHERE id = #{assignee_id}"
  got_person = run_sql(sql_get_person)
  @assignee = got_person.first['name']

  related_movie_id = @got_todo.first['related_to']
  sql_get_movie = "SELECT * FROM movies WHERE id = #{related_movie_id}"
  got_movie = run_sql(sql_get_movie)
  @for_movie = got_movie.first['title']

  erb :todo
end



