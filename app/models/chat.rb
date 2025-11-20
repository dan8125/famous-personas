class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :persona
  has_many :messages, dependent: :destroy

  validates :title, presence: true

  DEFAULT_TITLE = "Untitled"
  TITLE_PROMPT = <<~PROMPT
    Generate a short, human-like title (max 6 words) that summarizes the topic of the chat conversation between the user and persona.
  PROMPT

  def initial_title
    return unless title == DEFAULT_TITLE

    first_user_message = messages.where(role: "user").order(:created_at).first
    return if first_user_message.nil?

    response = RubyLLM.chat.with_instructions(TITLE_PROMPT).ask(first_user_message.content)
    update!(title: response.content)
  end
end
