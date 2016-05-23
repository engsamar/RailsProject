class Group < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :user #create relationShip
end
