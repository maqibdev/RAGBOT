require "net/http"
require "json"

class PythonApiService

  PYTHON_API_URL = "http://fastapi:8000/process/"

  def process_files_and_query(files, query)
    uri = URI(PYTHON_API_URL)
    request = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")

    # Collect URLs for the files
    file_urls = files.map { |file| url_for(file) }

    # Prepare the JSON payload
    payload = {
      query: query,
      file_urls: file_urls
    }.to_json

    request.body = payload

    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    puts response.body
    JSON.parse(response.body)["answer"]
  rescue StandardError => e
    Rails.logger.error("Error contacting Python API: #{e.message}")
    nil
  end

  private

  def url_for(file)
    Rails.application.routes.url_helpers.rails_blob_url(file, only_path: false)
  end
end
