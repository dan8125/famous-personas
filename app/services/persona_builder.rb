require "wikipedia"
require "open-uri"

class PersonaBuilder
  def initialize(name)
    @name = name
  end

  def build
    page = Wikipedia.find(@name)

    return { success: false, error: "Sorry, this person cannot be added to the chat options for now." } if page.nil? || page.summary.nil?

    bio = page.summary[0..250] # trim for display
    greeting = generate_greeting(@name)
    image_url =
      page.try(:main_image_url) ||
      page.try(:image).try(:url) ||
      page.image_urls&.first # fallback

    {
      success: true,
      bio: bio,
      greeting: greeting,
      image_url: image_url
    }
  end

  private

  def generate_greeting(name)
    greeting_prompt = <<~PROMPT
      Pretend that you are #{name}. Write a 1-2 sentence warm greeting to a user who wants to chat with you.
    PROMPT

    user_trigger_message = "Generate the greeting now."

    response = RubyLLM.chat.with_instructions(greeting_prompt).ask(user_trigger_message)
    response.content
  end
end
