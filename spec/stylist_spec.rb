require('spec_helper')

describe(Stylist) do

  describe('#first_name') do
    it('will return the first name of a stylist') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      expect(stylist.first_name).to(eq('Joe'))
    end
  end

  describe('#last_name') do
    it('will return the last name of a stylist') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      expect(stylist.last_name).to(eq('The Barber'))
    end
  end

  describe('.all') do
    it('will return an empty array when there are no stylists') do
      expect(Stylist.all).to(eq([]))
    end
  end
end
