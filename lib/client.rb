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

  def self.find(options)
    first_name = options.fetch(:first_name, nil)
    last_name  = options.fetch(:last_name, nil)
    full_name  = options.fetch(:full_name, nil)
    id         = options.fetch(:id, nil)

    clients = []
    if id
      result = DB.exec("SELECT * FROM clients WHERE id = #{id};")
      clients << Client.new(id: result.first['id'].to_i, first_name: result.first['first_name'], last_name: result.first['last_name'])
    elsif first_name
      results = DB.exec("SELECT * FROM clients WHERE first_name = '#{first_name}';")
      results.each do |result|
        clients << Client.find(id: result['id'].to_i).first
      end
    elsif last_name
      results = DB.exec("SELECT * FROM clients WHERE last_name = '#{last_name}';")
      results.each do |result|
        clients << Client.find(id: result['id'].to_i).first
      end
    elsif full_name
      name = full_name.split
      first_name = name.shift
      last_name = name.join(' ')
      results = DB.exec("SELECT * FROM clients WHERE first_name = '#{first_name}' AND last_name = '#{last_name}';")
      results.each do |result|
        clients << Client.find(id: result['id'].to_i).first
      end
    end
    clients
  end

  def stylist
    result = DB.exec("SELECT * FROM clients WHERE id = #{@id};")
    @stylist_id = result.first['stylist_id'].to_i
    if @stylist_id.==(0)
      stylist = nil
    else
      stylist = Stylist.find(id: @stylist_id).first
    end
  end

  def add_stylist(stylist)
    stylist.add_clients([self])
  end
end
