if Rails.env.development?
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins  /\Ahttp:\/\/localhost(?::\d+)?\z/
      resource "*",
               headers: :any,
               methods: [:get, :post, :options, :delete, :put, :patch, :head],
               credentials: true
    end
  end
end

if Rails.env.production?
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://video-sharing-fe-web.herokuapp.com', /\Ahttp:\/\/localhost(?::\d+)?\z/ # Add to test on local
      resource '/api/*',
               headers: :any,
               methods: [:get, :post, :put, :patch, :delete, :options, :head],
               credentials: true
    end
  end
end
