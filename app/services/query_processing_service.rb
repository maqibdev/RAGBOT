# app/services/query_processing_service.rb
class QueryProcessingService
  def initialize(chat, query_content, files = [])
    @chat = chat
    @query_content = query_content
    @files = files
  end

  def process
    create_query_and_response
  end

  def create_query_and_response
    title = @files.any? ? @files.last.original_filename : "Untitled"
    query = @chat.queries.create!(content: @query_content)

    @research_paper = @chat.research_papers.new(title: title, query_id: query.id)

    @files.each { |file| @research_paper.files.attach(file) }
    @research_paper.save!

    response_content = send_query_to_python
    query.create_response!(content: response_content)
  end

  def send_query_to_python
    PythonApiService.new.process_files_and_query(@research_paper.files, @query_content)
  end
end
