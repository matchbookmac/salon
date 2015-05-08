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

  describe('#full_name') do
    it('will return the full name of a stylist') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      expect(stylist.full_name).to(eq('Joe The Barber'))
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

  describe('.find') do
    it('will find a stylist by id') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      expect(Stylist.find(id: stylist.id)).to(eq([stylist]))
    end

    it('will find a stylist by first name') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      expect(Stylist.find(first_name: stylist.first_name)).to(eq([stylist]))
    end

    it('will find a multiple stylists with the same first name') do
      stylist_1 = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist_1.save
      stylist_2 = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Hairdresser')
      stylist_2.save
      expect(Stylist.find(first_name: stylist_1.first_name)).to(eq([stylist_1, stylist_2]))
    end

    it('will find a stylist by last name') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      expect(Stylist.find(last_name: stylist.last_name)).to(eq([stylist]))
    end

    it('will find a multiple stylists with the same last name') do
      stylist_1 = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist_1.save
      stylist_2 = Stylist.new(id: nil, first_name: 'Bill', last_name: 'The Barber')
      stylist_2.save
      expect(Stylist.find(last_name: stylist_1.last_name)).to(eq([stylist_1, stylist_2]))
    end

    it('will find a stylist by full_name name') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      expect(Stylist.find(full_name: stylist.full_name)).to(eq([stylist]))
    end
  end

  describe('#add_clients') do
    it('will add a client to a stylist') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      client.save
      stylist.add_clients([client])
      expect(client.stylist).to(eq(stylist))
    end

    it('will add a multiple clients to a stylist') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      client_1 = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      client_1.save
      client_2 = Client.new(id: nil, first_name: 'Mattie', last_name: 'Gregor', stylist_id: nil)
      client_2.save
      stylist.add_clients([client_1, client_2])
      expect(client_1.stylist).to(eq(stylist))
      expect(client_2.stylist).to(eq(stylist))
    end
  end

  describe('#update') do
    it('will update a stylist\'s first name') do
      stylist = Client.new(id: nil, first_name: 'Joe', last_name: 'The Barber', stylist_id: nil)
      stylist.save
      stylist.update(first_name: 'Bill')
      expect(stylist.first_name).to(eq('Bill'))
    end

    it('will update a stylist\'s last name') do
      stylist = Client.new(id: nil, first_name: 'Bill', last_name: 'The Barber', stylist_id: nil)
      stylist.save
      stylist.update(last_name: 'The Hairdresser')
      expect(stylist.last_name).to(eq('The Hairdresser'))
    end

    it('will update a stylist\'s full name') do
      stylist = Client.new(id: nil, first_name: 'Joe', last_name: 'The Barber', stylist_id: nil)
      stylist.save
      stylist.update(full_name: 'Bill The Hairdresser')
      expect(stylist.full_name).to(eq('Bill The Hairdresser'))
    end
  end

  describe('#delete') do
    it('will delete a stylist and update their clients\' stylist id') do
      stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist.save
      client_1 = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      client_1.save
      client_2 = Client.new(id: nil, first_name: 'Mattie', last_name: 'Gregor', stylist_id: nil)
      client_2.save
      stylist.add_clients([client_1, client_2])
      stylist.delete
      expect(client_1.stylist).to(eq(nil))
      expect(client_2.stylist).to(eq(nil))
    end
  end

  describe('.clear') do
    it('will clear all entries in the database') do
      stylist_1 = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
      stylist_1.save
      stylist_2 = Stylist.new(id: nil, first_name: 'Bill', last_name: 'The Barber')
      stylist_2.save
      Stylist.clear
      expect(Stylist.all).to(eq([]))
    end
  end
end
