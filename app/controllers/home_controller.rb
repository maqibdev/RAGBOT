class HomeController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    @research_paper = ResearchPaper.new
    @chat = current_user.chats.includes(queries: :response).order(created_at: :asc).last
  end
end
