class Client < ActiveRecord::Base
  belongs_to :user

  validates :name, :contact_person, :contact_number, presence: true
end
