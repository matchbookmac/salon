require('spec_helper')

describe(Client) do
  describe('#first_name') do
    it('will return the first name of a client') do
      client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      expect(client.first_name).to(eq('Ian'))
    end
  end

  describe('#last_name') do
    it('will return the last name of a client') do
      client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      expect(client.last_name).to(eq('MacDonald'))
    end
  end

  describe('#full_name') do
    it('will return the full name of a stylist') do
      client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      expect(client.full_name).to(eq('Ian MacDonald'))
    end
  end

  describe('.all') do
    it('will return an empty array when there are no clients') do
      expect(Client.all).to(eq([]))
    end
  end

  describe('#==') do
    it('will return true if the first and last name and id if two clients are the same') do
      client_1 = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      client_2 = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      expect(client_1).to(eq(client_2))
    end
  end

  describe('#save') do
    it('will save a client to the database') do
      client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      client.save
      expect(Client.all).to(eq([client]))
    end
  end

  describe('#id') do
    it('will return the unique id of a client') do
      client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
      client.save
      expect(client.id).to(be_an_instance_of(Fixnum))
    end
  end

  # describe('#stylist') do
  #   it('will return nil if there is no stylist for a client') do
  #     client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
  #     client.save
  #     expect(client.stylist).to(eq(nil))
  #   end

    # it('will return the stylist for a client') do
    #   stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
    #   stylist.save
    #   client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
    #   client.save
    #   stylist.add_client(client)
    #   expect
    # end
  # end

  # describe('#stylist_id') do
  #   it('will return nil if there is no stylist_id for a client') do
  #     client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
  #     client.save
  #     expect(client.stylist_id).to(eq(nil))
  #   end

    # it('will return the stylist_id for a client') do
    #   stylist = Stylist.new(id: nil, first_name: 'Joe', last_name: 'The Barber')
    #   stylist.save
    #   client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald', stylist_id: nil)
    #   client.save
    #   stylist.add_client(client)
    #   expect(client.stylist_id).to(eq(stylist.id))
    # end
  # end
end
