require 'pg'
require 'pry'
require_relative 'number'

class Contact

  attr_accessor :first_name, :last_name, :email, :id, :numbers

  @@contacts_list = []


  def initialize(first_name, last_name, email, id = nil, numbers = [])
    @first_name = first_name
    @last_name = last_name
    @email = email
    @id = id
    @numbers = numbers
  end

  def save
    if @id
      sql = 'UPDATE contacts SET firstname = $1, lastname = $2, email = $3 WHERE id=$4'
      self.class.connection.exec_params(sql, [@first_name, @last_name, @email, @id])
    else
      sql = 'INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) RETURNING id'
      result = self.class.connection.exec_params(sql, [@first_name, @last_name, @email])
      @id = result[0]['id'].to_i
    end
  end

  def add_number(type, num)
    number = Number.create(@id, type, num)
    @numbers << number
  end

  def destroy
    sql = 'DELETE FROM contacts WHERE id = $1'
    result = self.class.connection.exec_params(sql, [self.id])
  end

  class << self

    def connection
        PG.connect(
        host:'localhost',
        dbname: 'contacts',
        user: 'development',
        password: 'development')
    end

    def create(first_name, last_name, email)
      contact = Contact.new(first_name, last_name, email)
      contact.save
      @@contacts_list << contact
      contact
    end

    def find(id)
      result = connection.exec_params('SELECT * FROM contacts WHERE id = $1', [id])
      if result[0]
        Contact.new(result[0]['firstname'], result[0]['lastname'], result[0]['email'], result[0]['id'].to_i)
      end
    end

    def find_all_by_lastname(name)
      result = connection.exec_params('SELECT * FROM contacts WHERE lastname = $1', [name])
      outputs = []
      if result
        result.each do |contact|
          outputs << Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'].to_i)
        end
      end
      outputs[0]
    end

    def find_all_by_firstname(name)
      result = connection.exec_params('SELECT * FROM contacts WHERE firstname = $1', [name])
      outputs = []
      if result
        result.each do |contact|
          outputs << Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'].to_i)
        end
      end
      outputs[0]
    end

    def find_by_email(email)
      result = connection.exec_params('SELECT * FROM contacts WHERE email = $1', [email])
      outputs = []
      if result
        result.each do |contact|
          outputs << Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'].to_i)
        end
      end
      outputs
    end

    def find_by_number(number)
      id = Number.find_by_number(number)
      result = connection.exec_params('SELECT * FROM contacts WHERE id = $1', [id])
      outputs = []
      if result
        result.each do |contact|
          outputs << Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'].to_i)
        end
      end
      outputs[0]
    end

    def show_list
      @@contacts_list
    end

  end

end