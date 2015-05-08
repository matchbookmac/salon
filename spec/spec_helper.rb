require('pg')

DB = PG.connect(dbname: 'hair_salon_test')

require('./app')

require('rspec')
require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM clients;")
    DB.exec("DELETE FROM stylists;")
  end
end
