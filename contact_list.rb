#!/usr/bin/env ruby
require './contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  def self.menu
    puts "Here is a list of available commands:\n"\
    "   new    - Create a new contact\n"\
    "   list   - List all contacts\n"\
    "   show   - Show a contact\n"\
    "   search - Search contacts"
    ARGV[0], ARGV[1] = gets.chomp.split(' ')
    ContactList.new.selection
  end

  def selection
    case ARGV[0]
    when "list"
      total = 0
      arr = []
      Contact.all.each_with_index do |contact, index|
        total += 1
        arr << "#{index + 1} #{contact.name} (#{contact.email})"
      end 
        puts arr.shift(5)
        if arr.length < 6
          print "--- \n#{total} records total \n"
        else 
          input = STDIN.gets
          while input == "\n" && arr.length > 0
            if arr.length <=6
              puts arr.shift(6)
            else
              puts arr.shift(5)
              input = STDIN.gets
            end
          end
          print "--- \n#{total} records total \n"
        end 

    when "new"
      puts "Enter the contact name:"
      name = STDIN.gets.chomp
      puts "Enter the contact's email:"
      email = STDIN.gets.chomp
      contact = Contact.create(name, email)
      if contact
      puts "Contact created successfully, new contact ID is: #{contact.id}"
    else
      puts "Error, the contact email already exists and cannot be created"
    end

    when "show"
      unless ARGV[1] =~ /^\d+$/
        puts "Contact ID must be a number"
      else
        id = ARGV[1].to_i
        contact = Contact.find(id)
        if contact == nil
          puts "Contact Not found"
        else
          puts contact
        end
      end

    when "search"
      term = ARGV[1].to_s
      arr = Contact.search(term).each_with_index do |contact, index|
        puts "#{index + 1} #{contact.name} (#{contact.email})"
      end 
      puts "--- \n#{arr.length} records total"

    else
      puts "Invalid input"
    end
  end
end

if ARGV.empty?
  ContactList.menu
else
  ContactList.new.selection
end