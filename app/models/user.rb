class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friends
  has_many :orders
	has_many :friends, :through => :friend
	def self.search(search)
  # Title is for the above case, the OP incorrectly had 'name'
  where("email LIKE ?", "%#{search}%")
end
	
end

