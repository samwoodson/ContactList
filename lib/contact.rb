class Contact < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true

  # def self.all
  #   result = Connection.conn.exec("SELECT * from contact_list ORDER BY id;")
  #   contacts_array = []
  #   result.each_row do |row|
  #     id = row[0]
  #     name = row[1]
  #     email = row[2]
  #     contacts_array << Contact.new(name, email, id)
  #   end
  #   contacts_array
  # end

  # def self.create(name, email, id = nil, number = nil)
  #     return nil unless search(email).empty?
  #     Contact.new(name, email).save
  #   end

  # def self.find(id)
  #   contact = Connection.conn.exec_params("SELECT * FROM contact_list WHERE id = $1::int;", [id])
  #   if contact.ntuples > 0
  #     Contact.new(contact[0]['name'], contact[0]['email'], contact[0]['id'])
  #   end
  # end

  # def self.search(term)
  #   Connection.conn.exec_params("SELECT * FROM contact_list WHERE name ILIKE $1::varchar OR email ILIKE $1::varchar;", ['%'+term+'%']).inject([]) do |matches,contact|
  #     contact = Contact.new(contact['name'], contact['email'])
  #     matches << contact
  #   end
  # end

  # def save
  #   if id
  #     Connection.conn.exec_params("UPDATE contact_list SET name = $1, email = $2 WHERE id = $3::int;", [name, email, id])
  #   else
  #     contact = Connection.conn.exec_params("INSERT INTO contact_list (name, email) VALUES ($1, $2) RETURNING id;", [name, email])
  #     self.id = contact[0]['id']
  #   end
  #   self
  # end

  # def destroy
  #   Connection.conn.exec_params("DELETE FROM contact_list WHERE id = $1::int", [id])
  # end

end
