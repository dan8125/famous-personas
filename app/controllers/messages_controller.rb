class MessagesController < ApplicationController
  SYSTEM_PROMPT = "I am an interviewer who wants to chat with a famous person.\n\nRespond to my chats in that famous person's tone and way of speaking as if you were that person, including your history, background personality, etc. Make your responses as natural and human-like as possible.\n\nAnswer in a string."

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @persona = @chat.persona
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      @ruby_llm_chat = RubyLLM.chat
      conversation_history
      response = @ruby_llm_chat.with_instructions(instructions).ask(@message.content)
      # raise
      Message.create(role: "assistant", content: response.content, chat: @chat)
      @chat.reload
      @chat.initial_title

      respond_to do |format|
        format.html { redirect_to chat_messages_path(@chat) }
        format.turbo_stream { render 'create' }
      end
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def conversation_history
    @chat.messages.each do |message|
      @ruby_llm_chat.add_message(role: message.role, content: message.content)
    end
  end

  # system prompt, persona context + message i sent (send the chat history)
  def instructions
    persona_context = "Here is the context of the persona: #{@persona.content}."
    new_system_prompt = [ "Pretend that you are the famous person, #{@persona.name}.", SYSTEM_PROMPT ].join("\n\n")
    [new_system_prompt, persona_context, @persona.system_prompt].compact.join("\n\n")
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
