class Phone

  attr_reader :contact_id, :label, :number

  def initialize(contact_id, label, number)
    @contact_id = contact_id
    @label = label
    @number = number
  end

  def save
    Connection.conn.exec_params("INSERT INTO phones (contact_id, label, number) VALUES ($1, $2, $3) RETURNING *;", [contact_id, label, number])
  end

  def self.all
    result = Connection.conn.exec("SELECT * from phones ORDER BY id;")
    contacts_array = []
    result.each_row do |row|
      id = row[1]
      label = row[2]
      number = row[3]
      contacts_array << Phone.new(id, label, number)
    end
    contacts_array
  end

  def self.search(id)
     Connection.conn.exec_params("SELECT * FROM phones WHERE contact_id=$1::int;", [id]).inject([]) do |matches,phone|
      contact = Phone.new(phone['name'], phone['email'])
      matches << contact
    end
  end


end