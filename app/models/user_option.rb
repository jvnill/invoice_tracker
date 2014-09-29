class UserOption < ActiveRecord::Base
  OPTIONS   = %w[password_token password_reset_at]
  DATATYPES = %w[date datetime string integer decimal]

  belongs_to :user

  validates :name, presence: true, inclusion: { in: OPTIONS }
  validates :value, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :name }
  validates :datatype, inclusion: { in: DATATYPES }

  before_validation :set_datatype

  def self.create_or_initialize!(user, name, value)
    record = user.user_options.where(name: name).first_or_initialize
    record.value = value
    record.save!
  end

  private

  def set_datatype
    self.datatype = get_datatype_from_name
  end

  def get_datatype_from_name
    case name
    when 'password_token'    then 'string'
    when 'password_reset_at' then 'datetime'
    end
  end
end
