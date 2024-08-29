class HomeController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    @research_paper = ResearchPaper.new
    @chats = current_user.chats.includes(queries: :response).order(created_at: :asc)
  end
end
