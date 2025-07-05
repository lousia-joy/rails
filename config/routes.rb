Rails.application.routes.draw do
  root "home#index"
  resources :topics, only: [ :show ] do
    collection do
      get "stream", to: "topics#stream"  # 可选的轮询接口（WebSocket 备用）
    end
  end
  get "topics/:id/broadcast_fake_post", to: "topics#broadcast_fake_post", as: "topic_broadcast_fake_post"

  get "/proxy/image", to: "proxy#image"  # Instagram 图片代理

  mount ActionCable.server => "/cable"
end
