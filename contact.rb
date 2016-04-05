require 'csv'
require 'byebug'

FILEPATH = 'contacts.csv'
# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  attr_accessor :name, :email
  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email)
    @name = name
    @email = email
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      contacts_array = []
      CSV.foreach(FILEPATH) do |row|
        name = row[0]
        email = row[1]
        contact = Contact.new(name, email)
        contacts_array << contact
      end
      return contacts_array
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
        return nil unless search(email).empty?
        contact = Contact.new(name, email)
        CSV.open(FILEPATH, 'a') do |csv|
          csv << [contact.name,contact.email]
        end
        return File.open(FILEPATH).readlines.size
      end
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      csvarray = CSV.read(FILEPATH, 'r', converters: :numeric)
      csvarray[id - 1] ? csvarray[id - 1] : nil 
    end

    # puts arr.shift for pagination
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      Contact.all.select do |contact|
        contact.any? do |param|
          param =~ /#{term}/i ? true : false
        end
      end
    end

  end
