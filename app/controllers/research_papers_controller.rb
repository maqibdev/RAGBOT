class ResearchPapersController < ApplicationController
  def create
    # Find or create a chat for this session
    @chat = current_user.chats.find_or_create_by(title: "Session on #{Date.today}")

    @research_paper = @chat.research_papers.new(research_paper_params)

    if @research_paper.save
      # Send the files and query to the Python API service
      response_content = send_query_and_files_to_python(@research_paper.files, params[:research_paper][:query])

      # Save the query and response
      query = @chat.queries.create!(content: params[:research_paper][:query])
      query.create_response!(content: response_content)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            "chat-responses",
            partial: "home/response",
            locals: { query: query, response: query.response }
          )
        end
        format.html { redirect_to root_path, notice: "Research paper was successfully uploaded and query processed." }
        format.json { render json: { response: response_content }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render "home/index" }
        format.json { render json: @research_paper.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def research_paper_params
    # Permit the title and the files attached to the research paper
    params.require(:research_paper).permit(:title, files: [])
  end

  def send_query_and_files_to_python(files, query)
    # This method sends the ActiveStorage attachments and the query to the Python API service
    PythonApiService.new.process_files_and_query(files, query)
  end
end
