class User < ActiveRecord::Base
  statusable
  validates :first_name, :last_name, :email, presence: true

  alias_attribute :api_enabled?, :api_enabled

  def full_name
    "#{first_name} #{last_name}"
  end

  def enable_api
    key = api_key || SecureRandom.hex(12)
    update(api_key: key, api_enabled: true)
  end
end
