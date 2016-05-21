class WelcomeController < ApplicationController 
	before_filter :authenticate_user!
  def index
  	 @orders = Order.where(:user_id => current_user.id).limit(3).order("id desc")
  	 @activity=Order.limit(5).order("id desc")
  end
end
