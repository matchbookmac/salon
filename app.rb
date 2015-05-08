require('sinatra/reloader')
require('./lib/client')
require('./lib/stylist')
also_reload('/lib/**/*.rb')

if defined?(DB) == nil
  DB = PG.connect(dbname: 'hair_salon')
end
