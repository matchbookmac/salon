class Stylist
  attr_reader(:id, :first_name, :last_name)

  def initialize(attributes)
    @id         = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name  = attributes[:last_name]
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def self.all
    stylists = []
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    returned_stylists.each do |stylist|
      id         = stylist['id'].to_i
      first_name = stylist['first_name']
      last_name  = stylist['last_name']
      stylist_id = stylist['stylist_id'].to_i
      stylists << Stylist.new(id: id, first_name: first_name, last_name: last_name)
    end
    stylists
  end

  def ==(other_stylist)
    first_name.==(other_stylist.first_name) && last_name.==(other_stylist.last_name) && id.==(other_stylist.id)
  end

  def save
    result = DB.exec("INSERT INTO stylists (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def self.find(options)
    first_name = options.fetch(:first_name, nil)
    last_name  = options.fetch(:last_name, nil)
    full_name  = options.fetch(:full_name, nil)
    id         = options.fetch(:id, nil)

    stylists = []
    if id
      result = DB.exec("SELECT * FROM stylists WHERE id = #{id};")
      stylists << Stylist.new(id: result.first['id'].to_i, first_name: result.first['first_name'], last_name: result.first['last_name'])
    elsif first_name
      results = DB.exec("SELECT * FROM stylists WHERE first_name = '#{first_name}';")
      results.each do |result|
        stylists << Stylist.find(id: result['id'].to_i).first
      end
    elsif last_name
      results = DB.exec("SELECT * FROM stylists WHERE last_name = '#{last_name}';")
      results.each do |result|
        stylists << Stylist.find(id: result['id'].to_i).first
      end
    elsif full_name
      name = full_name.split
      first_name = name.shift
      last_name = name.join(' ')
      results = DB.exec("SELECT * FROM stylists WHERE first_name = '#{first_name}' AND last_name = '#{last_name}';")
      results.each do |result|
        stylists << Stylist.find(id: result['id'].to_i).first
      end
    end
    stylists
  end

  def add_clients(clients)
    clients.each do |client|
      client.update(stylist: self)
    end
  end

  def update(options)
    first_name = options.fetch(:first_name, nil)
    last_name  = options.fetch(:last_name, nil)
    full_name  = options.fetch(:full_name, nil)

    if first_name
      DB.exec("UPDATE clients SET first_name = '#{first_name}' WHERE id = #{@id};")
      @first_name = first_name
    elsif last_name
      DB.exec("UPDATE clients SET last_name = '#{last_name}' WHERE id = #{@id};")
      @last_name = last_name
    elsif full_name
      name = full_name.split
      @first_name = name.shift
      @last_name = name.join(' ')
      update(first_name: first_name, last_name: last_name)
    end
  end
end
