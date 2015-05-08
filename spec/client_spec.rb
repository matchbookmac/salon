require('spec_helper')

describe(Client) do
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
end
