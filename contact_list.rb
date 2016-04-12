#!/usr/bin/env ruby
require './contact'
require 'pg'

class ContactList

  def menu
    puts "Here is a list of available commands:\n"\
    "   new    - Create a new contact\n"\
    "   list   - List all contacts\n"\
    "   show   - Show a contact\n"\
    "   search - Search contacts"
    "   update - update contact id"
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
    contact = Contact.create(name, email)
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
    arr = Contact.search(term).each_with_index do |contact, index|
      puts "#{index + 1} #{contact.name} (#{contact.email})"
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

end

selection = ARGV[0]
option = ARGV[1]
ARGV.clear
Contact.connection


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
  else
   ContactList.new.menu
end
