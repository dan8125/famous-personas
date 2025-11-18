class Persona < ApplicationRecord
  has_many :chats

  validates :name, presence: true, uniqueness: true
  # validates :system_prompt, presence: true
  # validates :content, presence: true
end
