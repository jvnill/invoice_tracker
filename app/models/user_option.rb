class UserOption < ActiveRecord::Base
  OPTIONS   = %w[password_token password_reset_at]
  DATATYPES = %w[date datetime string integer decimal]

  belongs_to :user

  validates :name, presence: true, inclusion: { in: OPTIONS }
  validates :value, presence: true
  validates :datatype, presence: true, inclusion: { in: DATATYPES }

  before_validation :set_datatype

  private

  def set_datatype
    case name
    when 'password_token'    then 'string'
    when 'password_reset_at' then 'datetime'
    end
  end
end
