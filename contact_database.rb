## TODO: Implement CSV reading/writing
require 'pry'
require 'csv'


class ContactDatabase

  class << self
    def write_to_database(contact)
      CSV.open('contacts.csv', 'a') do |csv|
        csv << contact.to_s.split
      end
    end

    def read_database
      CSV.read('contacts.csv')
    end
  end
end