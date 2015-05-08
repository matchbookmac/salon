require('spec_helper')

describe('the hair salon path') do
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
end
