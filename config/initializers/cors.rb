if Rails.env.development?
  puts "---------- env ----------"
  puts "---------- development ----------"
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'www.example.com', /\Ahttp:\/\/localhost(?::\d+)?\z/
      resource "*",
               headers: :any,
               methods: [:get, :post, :options, :delete, :put, :patch, :head],
               credentials: true
    end
  end
end

if Rails.env.production?
  puts "---------- env ----------"
  puts "---------- production ----------"
  puts ENV["REDIS_URL"]
  puts ENV["REDIS_TLS_URL"]
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://video-sharing-fe-web.herokuapp.com'
      resource '/api/*',
               headers: :any,
               methods: [:get, :post, :put, :patch, :delete, :options, :head],
               credentials: true
    end
  end
end
