class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  has_many :user
end
