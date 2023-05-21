if Rails.env.development?
  puts "---------- env ----------"
  puts "---------- development ----------"
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins /\Ahttp:\/\/localhost(?::\d+)?\z/
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
