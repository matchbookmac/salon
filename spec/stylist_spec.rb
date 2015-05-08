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

  describe('#==') do
    it('will return true if the first and last name and id if two stylists are the same') do
      stylist_1 = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist_2 = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      expect(stylist_1).to(eq(stylist_2))
    end
  end

  describe('#save') do
    it('will save a stylist to the database') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      expect(Stylist.all).to(eq([stylist]))
    end
  end

  describe('#id') do
    it('will return the unique id of a stylist') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      expect(stylist.id).to(be_an_instance_of(Fixnum))
    end
  end

end
