class Stylist
  attr_reader(:id, :first_name, :last_name)

  def initialize(attributes)
    @id = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
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

end
