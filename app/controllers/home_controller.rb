require 'simple_app/sse.rb' 
class HomeController < ApplicationController
  include ActionController::Live

  def check
    # SSE expects the `text/event-stream` content type
    response.headers['Content-Type'] = 'text/event-stream'

    sse = SimpleApp::SSE.new(response.stream)
    begin
      20.times do
        messages = Message.where("created_at > ?", 3.seconds.ago)
        unless messages.empty?
          sse.write({messages: messages.as_json}, {event: 'refresh'})
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