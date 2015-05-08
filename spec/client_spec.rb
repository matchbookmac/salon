require('spec_helper')

describe(Client) do

  describe('#first_name') do
    it('will return the first name of a client') do
      client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald')
      expect(client.first_name).to(eq('Ian'))
    end
  end

  describe('#last_name') do
    it('will return the last name of a client') do
      client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald')
      expect(client.last_name).to(eq('MacDonald'))
    end
  end

  describe('.all') do
    it('will return an empty array when there are no clients') do
      expect(Client.all).to(eq([]))
    end
  end

  # describe('#save') do
  #   it('will return an array of clients when there are clients') do
  #     client = Client.new(id: nil, first_name: 'Ian', last_name: 'MacDonald')
  #     client.save
  #     expect(Client.all).to(eq([]))
  #   end
  # end

  # describe('#id') do
  #
  # end

  # # describe('#stylist_id') do
  #
  # end
end
