require('sinatra')
require('sinatra/reloader')
require('pry')
require('pg')
require('./lib/client')
require('./lib/stylist')
also_reload('/lib/**/*.rb')

if defined?(DB) == nil
  DB = PG.connect(dbname: 'hair_salon')
end

get('/') do
  erb(:index)
end
