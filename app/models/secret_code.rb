class SecretCode < ActiveRecord::Base
  belongs_to :user

  attr_accessor :count
  
  validates :code, presence: true, :uniqueness => { :case_sensitive => false }, allow_nil: true

  def self.generate_key
    key = loop do
      key = rand(36**rand(4..7)).to_s(36)
      break key unless SecretCode.exists?(code: key)
    end
    return key
  end
end
