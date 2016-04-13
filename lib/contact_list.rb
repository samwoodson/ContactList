#!/usr/bin/env ruby
require './setup'
require_relative 'contact'
class ContactList 

  def show_list
    total = 0
    arr = []
    list_of_all = Contact.all
    list_of_all.each do |contact|
      total += 1
      arr << "#{contact.id} #{contact.name} (#{contact.email})"
    end 
    puts arr.shift(5)
    if arr.length > 5
      input = gets
      while input == "\n" && arr.length > 0
        puts arr.shift(5)
        if arr.length > 0
          input = gets
        end
      end
    end
    print "--- \n#{total} records total \n"
  end

  def new_entry
    puts "Enter the contact name:"
    name = gets.chomp
    puts "Enter the contact's email:"
    email = gets.chomp
    contact = Contact.create(name: name, email: email)
    if contact
      puts "Contact created successfully, new contact ID is: #{contact.id}"
    else
      puts "Error, the contact email already exists and cannot be created"
    end
  end

  def show_id(id)

    unless id =~ /^\d+$/
      puts "Contact ID must be a number"
    else
      id = id.to_i
      contact = Contact.find(id)
      if contact == nil
        puts "Contact Not found"
      else
        puts "#{contact.name}, (#{contact.email})"
      end
    end
  end

  def search(term)
    arr = Contact.where("email ILIKE ? OR name ILIKE ?", '%'+term+'%', '%'+term+'%').each do |contact|
      puts "#{contact.id} #{contact.name} (#{contact.email})"
    end
    puts "--- \n#{arr.length} records total"
  end
  
  def update(id)
    puts "Enter updated contact name:"
    new_name = STDIN.gets.chomp
    puts "Enter updated contact email:"
    new_email = STDIN.gets.chomp
    contact = Contact.find(id)
    contact.name = new_name
    contact.email = new_email
    contact.save
    ContactList.new.show_id(id)
  end

  def destroy(id)
    contact = Contact.find(id)
    contact.destroy
  end

  def new_phone
    puts 'Enter contact id to add phone to:'
    contact_id = gets.chomp
    puts 'Enter label for phone number:'
    label = gets.chomp
    puts 'Enter 10 digit number, no spaces or dashes:'
    number = gets.chomp
    phone = Phone.new(contact_id, label, number)
    phone.save
  end

  def show_phones
    total = 0
    arr = []
    Phone.all.each_with_index do |phone, index|
      total += 1
      arr << "#{phone.contact_id} #{phone.label} (#{phone.number})"
    end 
    puts arr.shift(5)
    if arr.length > 5
      input = gets
      while input == "\n" && arr.length > 0
        puts arr.shift(5)
        if arr.length > 0
          input = gets
        end
      end
    end
    print "--- \n#{total} records total \n"
  end

  def search_phone
    puts "Enter contact id to find all phones belonging to them:"
    id = gets.chomp
    phones = Phone.search(id).each do |contact|
      puts "#{phone.label} (#{phone.number})"
    end
    puts "--- \n#{phones.length} records total"
  end
  
  def menu
    puts "Here is a list of available commands:\n"\
    "   new      - Create a new contact\n"\
    "   list     - List all contacts\n"\
    "   show     - Show a contact\n"\
    "   search   - Search contacts\n"\
    "   update   - update contact id\n"\
    "   newphone - enter new phone numbers\n"\
    "  allphones - show all phone numbers"
    "searchphones- find phone belonging to contact id"
  end

end

selection = ARGV[0]
option = ARGV[1]
ARGV.clear

case selection
  when 'list'
    ContactList.new.show_list
  when 'new'
    ContactList.new.new_entry
  when 'show'
    ContactList.new.show_id(option)
  when 'search'
    ContactList.new.search(option)
  when 'update'
    ContactList.new.update(option)
  when 'destroy'
    ContactList.new.destroy(option)
  when 'newphone'
    ContactList.new.new_phone
  when 'allphones'
    ContactList.new.show_phones
  when 'searchphone'
    ContactList.new.search_phone
  else
   ContactList.new.menu
end
