Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Only allow requests from your FastAPI service
    origins "http://fastapi:8000"  # Replace with the actual FastAPI URL

    # Allow all resource paths, with the specified methods and headers
    resource "*", headers: :any, methods: [ :get, :post, :put, :patch, :delete, :options, :head ]
  end
end
