require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'rainbow'


  # instead of writing this in every get/post. We write it once and store it in a function.
  def run_sql(sql)
    db = PG.connect(dbname: 'production', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end


