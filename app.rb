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
  redirect to('/')
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

patch('/stylists/:id/clients/add') do
  stylist = Stylist.find(id: params['id'].to_i).first
  client_ids = params['client_id']
  clients = []
  client_ids.each do |id|
    clients << Client.find(id: id.to_i).first
  end
  stylist.add_clients(clients)
  redirect to("/stylists/#{stylist.id}")
end

patch('/stylists/:id/clients/remove') do
  stylist = Stylist.find(id: params['id'].to_i).first
  client_ids = params['client_id']
  clients = []
  client_ids.each do |id|
    clients << Client.find(id: id.to_i).first
  end
  stylist.remove_clients(clients)
  redirect to("/stylists/#{stylist.id}")
end

delete('/stylists/:id') do
  stylist = Stylist.find(id: params['id'].to_i).first
  stylist.delete
  redirect to('/stylists')
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
  stylist_id = params['stylist_id'].to_i
  client = Client.new(id: nil, first_name: first_name, last_name: last_name, stylist_id: nil)
  client.save
  unless stylist_id == 0
    stylist = Stylist.find(id: stylist_id).first
    client.update(stylist: stylist)
  end
  redirect to("/clients/#{client.id}")
end

get('/clients/:id') do
  @client = Client.find(id: params['id'].to_i).first
  erb(:client)
end

delete('/clients/:id') do
  client = Client.find(id: params['id'].to_i).first
  client.delete
  redirect to('/clients')
end
