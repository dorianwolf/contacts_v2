require 'pg'

class Number

  attr_accessor :type, :num
  attr_reader :id, :contact_id

  @@numbers_list = []

  def initialize(contact_id, type, num, id = nil)
    @contact_id = contact_id
    @type = type
    @num = num
    @id = id
  end

  def save
    if @id
      sql = 'UPDATE numbers SET contact_id = $1, type = $2, number = $3'
      self.class.connection.exec_params(sql, [@contact_id, @type, @num])
    else
      sql = 'INSERT INTO numbers (contact_id, type, number) VALUES ($1, $2, $3) RETURNING id'
      result = self.class.connection.exec_params(sql, [@contact_id, @type, @num])
      @id = result[0]['id'].to_i
    end
  end

  class << self

    def connection
        PG.connect(
        host:'localhost',
        dbname: 'contacts',
        user: 'development',
        password: 'development')
    end

    def create(contact_id, type, num)
      number = Number.new(contact_id, type, num)
      number.save
      @@numbers_list << number
      number
    end

    def find_by_number(number)
      result = connection.exec_params('SELECT * FROM numbers WHERE number = $1', [number])
      output = nil
      if result
        result.each do |number|
          output = number['contact_id'].to_i
        end
      end
      output
    end



    def show(contact)

    end

  end

end