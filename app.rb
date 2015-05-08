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

get('/reset') do
  Client.clear
  Stylist.clear
  erb(:index)
end

get('/stylists') do
  @stylists = Stylists.all
  erb(:stylists)
end
