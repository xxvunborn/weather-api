class WeathersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "weathers_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
