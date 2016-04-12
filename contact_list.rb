#!/usr/bin/env ruby
require './contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  def menu
    puts "Here is a list of available commands:\n"\
    "   new    - Create a new contact\n"\
    "   list   - List all contacts\n"\
    "   show   - Show a contact\n"\
    "   search - Search contacts"
  end

  def show_list
    total = 0
    arr = []
    Contact.all.each_with_index do |contact, index|
      total += 1
      arr << "#{index + 1} #{contact.name} (#{contact.email})"
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
    puts "Enter phone number and label or leave blank:"
    input = gets
    if input == "\n"
      contact = Contact.create(name, email)
    else
      number_array = []
      number_array << input
      loop do
        puts "Enter another number and label or leave blank:"
        another_number = gets
        break if another_number == "\n"
        number_array << another_number
      end
      contact = Contact.create(name, email, nil, number_array)
    end
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
        puts contact
      end
    end
  end

  def search(term)
    arr = Contact.search(term).each_with_index do |contact, index|
      puts "#{index + 1} #{contact.name} (#{contact.email})"
    end 
    puts "--- \n#{arr.length} records total"
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
    ContactList.new.show_id(selection)
  when 'search'
    ContactList.new.search(option)
  else
   ContactList.new.menu
end
