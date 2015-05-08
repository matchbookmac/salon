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
    it('will navigate to stylists and show a list of available stylists and navigate home') do
      visit('/stylists')
      expect(page).to have_content('Sorry, there are no stylists at this time.')
      click_on('Home')
      expect(page).to have_content('Hair by Ian!')
      expect(page).to have_content('Stylists')
      expect(page).to have_content('Clients')
    end
  end
end
