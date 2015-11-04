class Contact < ActiveRecord::Base

  validates :firstname, :lastname, :email, presence: true

  has_many :numbers


end