require_relative 'contact'
require_relative 'contact_database'

# TODO: Implement command line interaction
# This should be the only file where you use puts and gets

def help
  puts "Here is a list of available commands:"
  puts "new - Create a new contact"
  puts "list - List all contacts"
  puts "show - Show a contact"
  puts "find - Find a contact"

end

def new_user
  puts "Please enter the full name"
  name = STDIN.gets.chomp
  puts "Please enter the email address"
  email = STDIN.gets.chomp
  puts "Add a phone number?"
  add_number = STDIN.gets.chomp == "yes"
  numbers = {}
  while add_number do
    puts "What's the number?"
    number = STDIN.gets.chomp
    puts "What kind of phone is this?"
    type = STDIN.gets.chomp
    puts "Add another?"
    numbers[type] = number
    add_number = STDIN.gets.chomp == "yes"
  end

  Contact.create(name, email, numbers)

end

def list
  puts Contact.all
end

def show(id)
  puts Contact.show(id)
end

def find(term)
  puts Contact.find(term)
end


# after all methods defined, get user input

command = ARGV[0]
parameter = ARGV[1]

case command
when "help"
  help
when "new"
  new_user
when "list"
  list
when "show"
  show(parameter)
when "find"
  find(parameter)
else puts "did not understand input"
end