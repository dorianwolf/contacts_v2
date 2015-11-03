class Contact

  attr_accessor :first_name, :last_name, :email
  attr_reader :id

  @@contacts_list = []


  def initialize(first_name, last_name, email)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @id = @@contacts_list.length
  end

  def save
    if @id
      sql = 'UPDATE contacts SET firstname = $1, lastname = $2, email = $3 WHERE id=$4'
      self.connection.exec_parameters(sql, [@first_name, @last_name, @email, @id])
    else
      sql = 'INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) RETURNING id'
      result = self.class.connection.exec_parameters(sql, [@first_name, @last_name, @email])
      @id = result[0]['id'].to_i
    end

  end

  def destroy

  end

  class << self

    def connect

    end

    def create(first_name, last_name, email)
      contact = Contact.new(first_name, last_name, email)
      @@contacts_list << contact
      contact.save
    end

    def find(id)

    end

    def find_all_by_lastname(name)

    end

    def find_all_by_firstname(name)
      
    end

    def find_by_email(email)

    end

  end

end