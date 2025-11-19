class ChatsController < ApplicationController
  def create
    @persona = Persona.find(params[:persona_id])

    @chat = Chat.new(title: Chat::DEFAULT_TITLE)
    @chat.persona = @persona
    @chat.user = current_user

    if @chat.save
      redirect_to chat_path(@chat)
    else
      render "personas/show"
    end
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @message = Message.new
  end
end
