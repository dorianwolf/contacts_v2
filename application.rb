require_relative 'setup'

class Application

  class << self

    def begin
      puts "What would you like to do?"
      input = gets.chomp.downcase
      case input
      when "create"
        Application.create
        Application.begin
      when "find"
        Application.read
        Application.begin
      when "delete"
        Application.delete
        Application.begin
      when "quit"
        puts "fine.."
      else 
        puts "huh?"
        Application.begin
      end
    end

    def create
      puts "Ok, we'll create a new contact"
      puts "What's the first name?"
      first_name = gets.chomp
      puts "What's the last name?"
      last_name = gets.chomp
      puts "What's the email?"
      email = gets.chomp
      contact = Contact.create(firstname: first_name, lastname: last_name, email: email)
      id = contact.id
      Application.create_number(id)
    end

    def create_number(id)
      puts "Add a phone number?"
      input = gets.chomp.downcase
      case input
      when 'yes'
        puts "Great! What's the number?"
        num = gets.chomp
        puts "What kind of number is this?"
        kind = gets.chomp
        Number.create(contact_id: id, kind: kind, number: num)
      when 'no'
        puts "ok"
      else
        puts 'huh?'
        Application.create_number
      end
    end

    def read
      puts "What attribute are you going to give me?"
      search = gets.chomp.downcase
      puts "What is it called?"
      value = gets.chomp
      case search
      when "firstname"
        output = Contact.find_by(firstname: value)
      when "lastname"
        output = Contact.find_by(lastname: value)
      when "email"
        output = Contact.find_by(email: value)
      else
        puts "I didn't understand. Try again."
        Application.read
      end
      puts output.inspect
    end

    def delete
      puts "What contact ID?"
      id = gets.chomp.to_i
      Contact.find(id).destroy
      puts "DELETED"
    end

  end

end

Application.begin

