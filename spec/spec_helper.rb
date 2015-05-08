require('pry')
require('pg')
require('rspec')
require('capybara/rspec')
require('sinatra')
# require('client')
# require('stylist')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

DB = PG.connect(dbname: 'hair_salon_test')

require('./app')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM clients;")
    DB.exec("DELETE FROM stylists;")
  end
end
