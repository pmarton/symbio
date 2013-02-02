class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
         :trackable, :validatable, :token_authenticatable, :confirmable,
         :encryptable, :encryptor => :restful_authentication_sha1

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :admin, :confirmed_at
  
  has_and_belongs_to_many :orders
  has_many :invoice_items
  
  validates_presence_of :name
  
end
