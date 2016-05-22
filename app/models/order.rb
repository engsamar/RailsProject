class Order < ActiveRecord::Base
  belongs_to :user
  has_many :orderdetails
  has_many :invitations
end
