class Client
  attr_reader(:id, :first_name, :last_name, :stylist_id)

  def initialize(attributes)
    @id         = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name  = attributes[:last_name]
    @stylist_id = attributes[:stylist_id]
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def self.all
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients;")
    returned_clients.each do |client|
      id         = client['id'].to_i
      first_name = client['first_name']
      last_name  = client['last_name']
      stylist_id = client['stylist_id'].to_i
      clients << Client.new(id: id, first_name: first_name, last_name: last_name, stylist_id: stylist_id)
    end
    clients
  end

  def ==(other_client)
    first_name.==(other_client.first_name) && last_name.==(other_client.last_name) && id.==(other_client.id)
  end

  def save
    result = DB.exec("INSERT INTO clients (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  # def stylist
  #   result = DB.exec("SELECT * FROM clients WHERE id = #{@id};")
  #   @stylist_id = result.first['stylist_id'].to_i
  #   if @stylist_id.==(0)
  #     @stylist = nil
  #   end
  #   stylist = Stylist.find(id: @stylist_id)
  # end
end
