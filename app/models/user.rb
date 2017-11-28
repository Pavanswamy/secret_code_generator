class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:vistor, :admin]

  has_one :secret_code, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :secret_code

  validates_presence_of :first_name, :last_name

end
