class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [ :show, :create ]

  def index
    @chats = current_user.chats.order(created_at: :desc)
  end

  def new
    @chat = Chat.new
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.turbo_stream
    end
  end

  def create
    if @chat.present?
      service = QueryProcessingService.new(@chat, chat_params[:query], chat_params[:files])
      service.process
      notice_message = "Query was successfully added."
    else
      @chat = current_user.chats.create!(title: "Session: #{chat_params[:query].split(' ').first(5).join(' ')}")
      service = QueryProcessingService.new(@chat, chat_params[:query], chat_params[:files])
      service.process
      notice_message = "Chat and query were successfully created."
    end

    respond_to do |format|
      format.html { redirect_to chat_path(@chat), notice: notice_message }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("chat-container", template: "chats/show", locals: { chat: @chat }) }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { render :new }
      format.json { render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity }
    end
  end

  private

  def set_chat
    @chat = current_user.chats.find_by(id: params[:id] || params.require(:chat)[:id])
  end

  def chat_params
    params.require(:chat).permit(:query, files: [])
  end
end
