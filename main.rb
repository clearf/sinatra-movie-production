require 'pg'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'

def blank?(thing)
  return true if thing.nil?
  if thing.respond_to? :empty?
    return thing.empty?
  else
    return false
  end
end

def run_sql(sql)
  # puts "*~" * 31
  # puts sql
  # puts "*~" * 31
  db = PG.connect(dbname:'movie_manager', host:'localhost')
  result = db.exec(sql)
  db.close
  result       ## return not needed -
end


#######################
#### MODEL #######
##############

####################
### CONTROLLERS ####
###################

#Allows user to see tasks
get '/' do
  @tasks = run_sql("SELECT * FROM tasks")
  @people = run_sql("SELECT * FROM people")
  @movies = run_sql("SELECT * FROM movies")
  erb :tasks
end

get '/tasks/:id' do
  @task = run_sql("SELECT * from tasks where id = #{params[:id]}").first
  @people = run_sql("SELECT * from people")
  @movies = run_sql("Select * from movies")
  erb :task
end

post '/tasks/:id' do
  id = params[:id]
  task = params[:task]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]
  completed = params[:completed]

  sql = %Q{
    UPDATE tasks
       SET task = '#{task}',
           description = '#{description}',
           person_id = #{blank?(person_id) ? 'NULL' : person_id},
           movie_id = #{blank?(movie_id) ? 'NULL' : movie_id},
           completed = '#{blank?(completed) ? 'f' : 't'}'

     WHERE id = #{id}
  }
  run_sql(sql)
  redirect "/tasks/#{id}"
end

#Allows user to post to tasks from withing tasks.erb
post '/tasks' do
  task = params[:task]
  description = params[:description]
  person_id = params[:person_id]
  movie_id= params[:movie_id]
  sql = %Q{INSERT INTO tasks
    (task, description, person_id, movie_id)
    VALUES
    ('#{task}',
      '#{description}',
      #{person_id},
      #{movie_id}) }
  run_sql(sql)
  redirect to '/'
end

# Allows user to see people table
get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

post '/people' do
  name = params[:name]
  title = params[:title]
  phone = params[:phone]
  sql = %Q{INSERT INTO people (name, title, phone)
    VALUES ('#{name}',
     '#{title}',
     '#{phone}')}
  run_sql(sql)
  redirect to '/people'
end

# #Allows user to see movies table
get '/movies' do
  sql_movies = "SELECT * FROM movies"
  sql_people = "SELECT * FROM people"
  @people = run_sql(sql_people)
  @movies = run_sql(sql_movies)
  erb :movies
end

post '/movies' do
  title = params[:title]
  image = params[:image]
  person_id = params[:person_id]
  sql = %Q{INSERT INTO movies(title, image, director_id)
      VALUES ('#{title}',
              '#{image}',
              '#{person_id}')}
  run_sql(sql)
  redirect to '/movies'
end