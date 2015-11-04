class Number < ActiveRecord::Base

  validates :kind, presence: true
  validates :number, presence: true

  belongs_to :contact

end