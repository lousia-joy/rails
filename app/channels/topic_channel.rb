class TopicChannel < ApplicationCable::Channel
  def subscribed
    topic = params[:topic]
    stream_from "topic_#{topic}"
  end

  def unsubscribed
    # 取消订阅时可以做清理
  end
end
