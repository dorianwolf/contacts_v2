require_relative 'setup'

class Application

  class << self

    def begin
      puts "What would you like to do?"
      input = gets.chomp.downcase
      case input
      when "create"
        Application.create
      when "find"
        Application.read
      when "update"
        Application.save
      when "delete"
      when "nothing"
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
      contact = Contact.create(first_name, last_name, email)
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

    def read(id)

    end

    def update
    end

    def delete
      puts ""
    end

  end

end

Application.begin