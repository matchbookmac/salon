require('spec_helper')

describe('the hair salon path', {:type => :feature}) do
  describe('home page') do
    it('will take the user to the home page') do
      visit('/')
      expect(page).to have_content('Hair by Ian!')
      expect(page).to have_content('Stylists')
      expect(page).to have_content('Clients')
    end
  end

  describe('stylists') do
    it('will navigate to stylists and show no stylists if there are none and navigate home') do
      visit('/stylists')
      expect(page).to have_content('Sorry, there are no stylists at this time.')
      click_on('Home')
      expect(page).to have_content('Hair by Ian!')
      expect(page).to have_content('Stylists')
      expect(page).to have_content('Clients')
    end

    it('will navigate to stylists and show a list of stylists') do
      stylist_1 = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist_1.save
      stylist_2 = Stylist.new(id: nil, first_name: 'Bill', last_name: 'The Hairdresser')
      stylist_2.save
      visit('/stylists')
      expect(page).to have_content('Here is a list of available stylists:')
      expect(page).to have_content('Joe The Barber')
      expect(page).to have_content('Bill The Hairdresser')
    end
  end

  describe('add stylist') do
    it('will navigate to stylists, and add a new stylist') do
      visit('/stylists')
      expect(page).to have_content('Sorry, there are no stylists at this time.')
      click_on('Add a Stylist')
      fill_in('first_name', with: 'Joe')
      fill_in('last_name', with: 'The Barber')
      click_on('Add')
      expect(page).to have_content('Joe The Barber')
      expect(page).to have_content('Sorry, there are no clients for this stylist at this time.')
    end
  end

  describe('add clients to a stylist') do
    it('will navigate to stylists, and add new clients') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      client_1 = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      client_1.save
      client_2 = Client.new(id: nil, first_name: 'Mattie', last_name: 'Gregor', stylist_id: nil)
      client_2.save
      visit("/stylists/#{stylist.id}")
      find(:css, "##{client_1.id.to_i}").set(true)
      click_on('Add')
      expect(page).to have_content('Joe\'s clients: Ian MacDonald')
    end
  end

  describe('remove clients from a stylist') do
    it('will navigate to stylists, and add new clients') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      client_1 = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      client_1.save
      client_2 = Client.new(id: nil, first_name: 'Mattie', last_name: 'Gregor', stylist_id: nil)
      client_2.save
      stylist.add_clients([client_1, client_2])
      visit("/stylists/#{stylist.id}")
      expect(page).to have_content('Joe\'s clients: Ian MacDonald Mattie Gregor')
      find(:css, "##{client_1.id}").set(true)
      click_on('Remove')
      expect(page).to have_content('Joe\'s clients: Mattie Gregor')
    end
  end

  describe('delete stylist') do
    it('will delete a stylist') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      visit("/stylists/#{stylist.id}")
      click_on('Delete This Stylist')
      expect(page).to have_content('Sorry, there are no stylists at this time.')
    end
  end

  describe('clients') do
    it('will navigate to clients and show no clients if there are none and navigate home') do
      visit('/clients')
      expect(page).to have_content('Sorry, there are no clients at this time.')
    end

    it('will navigate to clients and show a list of clients') do
      client_1 = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      client_1.save
      client_2 = Client.new(id: nil, first_name: 'Mattie', last_name: 'Gregor', stylist_id: nil)
      client_2.save
      visit('/clients')
      expect(page).to have_content('Here is a list of available clients:')
      expect(page).to have_content('Ian MacDonald')
      expect(page).to have_content('Mattie Gregor')
    end
  end

  describe('add client') do
    it('will navigate to clients, and add a new client without stylist') do
      visit('/clients')
      expect(page).to have_content('Sorry, there are no clients at this time.')
      click_on('Add a Client')
      fill_in('first_name', with: 'Ian')
      fill_in('last_name', with: 'MacDonald')
      click_on('Add')
      expect(page).to have_content('Ian MacDonald')
      expect(page).to have_content('This client does not have a stylist at this time.')
    end

    it('will navigate to clients, and add a new client with stylist') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      visit('/clients')
      expect(page).to have_content('Sorry, there are no clients at this time.')
      click_on('Add a Client')
      fill_in('first_name', with: 'Ian')
      fill_in('last_name', with: 'MacDonald')
      find('#stylist_id').find(:xpath, 'option[2]').select_option
      click_on('Add')
      expect(page).to have_content('Ian MacDonald')
      expect(page).to have_content('Joe The Barber styles Ian\'s hair')
    end
  end

  describe('delete client') do
    it('will delete a client') do
      client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      client.save
      visit("/clients/#{client.id}")
      click_on('Delete This Client')
      expect(page).to have_content('Sorry, there are no clients at this time.')
    end
  end
end
