require 'pry'
require_relative 'contact_database'

class Contact

  @@contacts_list = ContactDatabase.read_database
 
  attr_accessor :name, :email
  attr_reader :id


  def initialize(name, email, numbers = {})
    @name = name
    @email = email
    @numbers = numbers
    @id = @@contacts_list.length + 1
  end
 
  def to_s
    string = "#{@id}: #{@name} (#{@email})"
    @numbers.each do |key, value|
      string << ", #{key}: #{value}"
    end
    string
  end
 
  ## Class Methods
  class << self
    def create(name, email, numbers)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      duplicate = false
      @@contacts_list.each do |contact|
        duplicate = true if contact[2] == "#{}"
      end
      contact = Contact.new(name, email, numbers) unless duplicate
      if duplicate then
        return nil
      else
        @@contacts_list << contact
        ContactDatabase.write_to_database(contact)
        contact
      end
    end
 
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
      output = nil
      contacts = ContactDatabase.read_database
      contacts.each do |contact|
        output = contact if contacts = /#{term}/
      end
      if output then
        output.join(' ') 
      else
        nil
      end
    end
 
    def all
      # TODO: Return the list of contacts, as is
      output = []
      contacts = ContactDatabase.read_database
      contacts.each do |contact|
        output << contact.join(' ')
      end
      output
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      output = nil
      output = @@contacts_list[id.to_i - 1]
      output.join(' ')
    end
    
  end
 
end