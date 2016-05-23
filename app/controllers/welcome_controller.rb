require 'simple_app/sse.rb' 
class WelcomeController < ApplicationController
  include ActionController::Live

  # before_filter :authenticate_user!
    
  # session[:n]=1
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


 # push notification function
  def check
    # SSE expects the `text/event-stream` content type
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SimpleApp::SSE.new(response.stream)
    begin
      10.times do
       t = Time.now
        t = t - 3
        invits = Invitation.where("user_id = ?",current_user.id).where("created_at > ?" , t)
        unless invits.empty?
          # make your action here for notification
          sse.write({invits: invits.as_json}, {event: 'refresh'})
        end
        sleep 3
      end
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
    end
  end


  def notify
     @invits = Invitation.where("user_id = ?",current_user.id)
     @user_invits=[]
     @invits.each do |invit|
       puts invit.id
       @id=invit.order_id
       puts @id
       @record = Order.find_by("id = ?",@id)
       puts @record.name
       @user_invits << {"name" => @record.name , "restaurant" => @record.restaurant , "invite_id"=> invit.id , "joined" => invit.is_join} 
        # @orders=Order.where(id:Invitation.where(:user_id => current_user.id))
      # @orders=Order.where(id: Invitation.select("order_id").where(:user_id => current_user.id))
     end
     # @orders = []
     # @user_invits.each do |f|
     #    # abort("sss")
        
     #   @orders << @ord.name 
     # end
  end

end
