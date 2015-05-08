class Client
  attr_reader(:id, :first_name, :last_name, :stylist_id)

  def initialize(attributes)
    @id = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @stylist_id = attributes[:stylist_id]

  end
end
