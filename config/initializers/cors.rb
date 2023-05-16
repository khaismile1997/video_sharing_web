if Rails.env.development?
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

if Rails.env.heroku?
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins /\Ahttps?:\/\/video\-[a-z\-\d]+\.herokuapp\.com\/?\z/
      resource "*",
               headers: :any,
               methods: [:get, :post, :options, :delete, :put, :patch, :head],
               credentials: true
    end
  end
end
