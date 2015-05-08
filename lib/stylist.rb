class Stylist
  attr_reader(:id, :first_name, :last_name)

  def initialize(attributes)
    @id = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def self.all
    stylists = []
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    returned_stylists.each do |stylist|
      id = stylist['id'].to_i
      first_name = stylist['first_name']
      last_name = stylist['last_name']
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

  # def add_clients(clients)
  #   clients.each do |client|
  #     DB.exec("UPDATE clients SET stylist_id = #{@id} WHERE id = #{client.id};")
  #   end
  # end
end
