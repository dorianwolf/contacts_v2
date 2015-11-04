require 'pry'
require 'active_record'
require_relative 'contact_v3'
require_relative 'number_v3'

# Output messages from AR to STDOUT
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "Establishing connection to database ..."
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'unicode',
  pool: 5,
  database: 'contacts',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  min_messages: 'error'
)
puts "CONNECTED"

puts "Setting up Database (recreating tables) ..."

ActiveRecord::Schema.define do
  drop_table :contacts if ActiveRecord::Base.connection.table_exists?(:contacts)
  drop_table :numbers if ActiveRecord::Base.connection.table_exists?(:numbers)

  create_table :contacts do |c|
    c.column :firstname, :string
    c.column :lastname, :string
    c.column :email, :string
    c.timestamps null: false
  end

  create_table :numbers do |n|
    n.references :contact
    n.column :kind, :string
    n.column :number, :string
    n.timestamps null: false
  end
end

puts "Setup DONE"



# Create example data
def populate
  require 'faker'

  10.times do
    Contact.create!(
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      email: Faker::Internet.email,
    )
  end

  contacts = Contact.all.to_a
  100.times do
    Number.create!(
      kind: Faker::Book.title,
      number: Faker::Base.numerify('###-###-####'),
      contact_id: contacts.sample.id
    )
  end
end
