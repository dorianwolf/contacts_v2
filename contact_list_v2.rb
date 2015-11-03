require 'pg'

class Contact

  attr_accessor :first_name, :last_name, :email, :id

  @@contacts_list = []


  def initialize(first_name, last_name, email, id = nil)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @id = id
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
          outputs << Contact.new(contact['firstname'], contact['lastname'], contact['email'])
        end
      end
      outputs
    end

    def find_all_by_firstname(name)
      result = connection.exec_params('SELECT * FROM contacts WHERE firstname = $1', [name])
      outputs = []
      if result
        result.each do |contact|
          outputs << Contact.new(contact['firstname'], contact['lastname'], contact['email'])
        end
      end
      outputs
    end

    def find_by_email(email)
      result = connection.exec_params('SELECT * FROM contacts WHERE email = $1', [email])
      outputs = []
      if result
        result.each do |contact|
          outputs << Contact.new(contact['firstname'], contact['lastname'], contact['email'])
        end
      end
      outputs
    end

    def show_list
      @@contacts_list
    end

  end

end