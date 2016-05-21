require 'simple_app/sse.rb' 
class WelcomeController < ApplicationController
  include ActionController::Live
  before_filter :authenticate_user!

  def index
  	 @orders = Order.where(:user_id => current_user.id).limit(3).order("id desc")
  	 @activity=Order.limit(5).order("id desc")
  end

 # push notification function
  def check
    # SSE expects the `text/event-stream` content type
    response.headers['Content-Type'] = 'text/event-stream'

    sse = SimpleApp::SSE.new(response.stream)
    begin
      20.times do
        messages = Message.where("created_at > ?", 3.seconds.ago)
        unless messages.empty?
          # make your action here for notification
          # sse.write({messages: messages.as_json}, {event: 'refresh'})
        end
        sleep 3
      end
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
    end
  end

end
