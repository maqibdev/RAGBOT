class HomeController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    @research_paper = ResearchPaper.new
  end
end
