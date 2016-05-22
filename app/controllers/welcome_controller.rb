class WelcomeController < ApplicationController 
	before_filter :authenticate_user!
  def index
  	 @orders = Order.where(:user_id => current_user.id).limit(3).order("id desc")
  	 #select current user friends 
  	 @friends= Friend.where(:user_id => current_user.id)
  	 @user_friend=[]
  	 @friends.each do |friend|
  	 	@id=friend.friend_id
  	 	@user_friend << User.find_by(id:@id)
  	 end
  end
end
