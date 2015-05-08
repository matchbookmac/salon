require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/client')
require('./lib/stylist')
also_reload('lib/**/*.rb')

if defined?(DB) == nil
  require('pg')
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
  @stylists = Stylist.all
  erb(:stylists)
end

get('/stylists/add') do
  erb(:stylist_form)
end

post('/stylists/add') do
  first_name = params['first_name']
  last_name = params['last_name']
  stylist = Stylist.new(id: nil, first_name: first_name, last_name: last_name)
  stylist.save
  redirect to("/stylists/#{stylist.id}")
end

get('/stylists/:id') do
  @stylist = Stylist.find(id: params['id'].to_i).first
  erb(:stylist)
end

get('/clients') do
  @clients = Client.all
  erb(:clients)
end

get('/clients/add') do
  @stylists = Stylist.all
  erb(:client_form)
end

post('/clients/add') do
  first_name = params['first_name']
  last_name = params['last_name']
  stylist = params['stylist']
  if stylist == ""
    stylist = nil
  end
  client = Client.new(id: nil, first_name: first_name, last_name: last_name, stylist_id: stylist)
  client.save
  redirect to("/clients/#{client.id}")
end

get('/clients/:id') do
  @client = Client.find(id: params['id'].to_i).first
  erb(:client)
end
