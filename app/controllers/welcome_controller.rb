require 'simple_app/sse.rb' 
class WelcomeController < ApplicationController
  include ActionController::Live
  before_filter :authenticate_user!
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
      20.times do
       # messages = Message.where("created_at > ?", 3.seconds.ago)
        invits = Invitation.where("user_id = ?",current_user.id)
        unless invits.empty?
           # sse.write({messages: messages.as_json}, {event: 'refresh'})
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

  end

end
