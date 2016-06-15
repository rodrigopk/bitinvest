if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { :url => 'redis://127.4.75.131:16379/0' }
  end
  Sidekiq.configure_client do |config|
    config.redis = { :url => 'redis://127.4.75.131:16379/0' }
  end
else
  Sidekiq.configure_server do |config|
    config.redis = { :url => 'redis://localhost:6379'}
  end
  Sidekiq.configure_client do |config|
    config.redis = { :url => 'redis://localhost:6379' }
  end
end