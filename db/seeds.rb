# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"

puts "Cleaning database..."

Chat.destroy_all
User.destroy_all
Persona.destroy_all

puts "Creating users..."
haruna = User.create!(email: "haruna@gmail.com", password: "123456")
steve = User.create!(email: "steve@gmail.com", password: "123456")
dan = User.create!(email: "dan@gmail.com", password: "123456")
puts "Created users."


puts "Attaching user photos..."

haruna_file = URI.parse("https://avatars.githubusercontent.com/u/236273565?v=4").open
haruna.photo.attach(io: haruna_file, filename: "haruna.jpg", content_type: "image/jpg")

steve_file = URI.parse("https://avatars.githubusercontent.com/u/212231809?v=4").open
steve.photo.attach(io: steve_file, filename: "steve.jpg", content_type: "image/jpg")

dan_file = URI.parse("https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBdzZLQkE9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--193425d429fc8f3994d4c49f5e909c5126068afb/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lKU2xCRlJ3WTZCa1ZVT2hOeVpYTnBlbVZmZEc5ZlptbHNiRnNJYVFISWFRSElld1k2Q1dOeWIzQTZEbUYwZEdWdWRHbHZiZz09IiwiZXhwIjpudWxsLCJwdXIiOiJ2YXJpYXRpb24ifX0=--c1ef12f4b4a301a4d301848fb027c3aaf2b50191/IMG_6588_2.JPEG").open
dan.photo.attach(io: dan_file, filename: "dan.jpg", content_type: "image/jpg")

puts "Attached users photo."


puts "Creating personas..."

elizabeth_file = URI.parse("https://assets.vogue.com/photos/5f6d05918c75f02cb3917f28/16:9/w_1920%2Cc_limit/fp111_107a_her_majesty_queen_elizabeth_xl_02618_2008131904_id_1316166.jpg").open
elizabeth = Persona.new(
  name: "Queen Elizabeth",
  category: "historical person",
  bio: "Queen Elizabeth II (1926–2022) was the longest-reigning British monarch, known for her dedication, resilience, and service. She guided the UK and Commonwealth through decades of change, becoming a symbol of stability and continuity.",
  greeting: "Good day. I am pleased to welcome you, and should you wish to begin a conversation, I shall be here with dignity and attention."
  )
elizabeth.photo.attach(io: elizabeth_file, filename: "elizabeth.jpg", content_type: "image/jpg")
elizabeth.save

puts "Created Queen Elizabeth"

spongebob_file = URI.parse("https://upload.wikimedia.org/wikipedia/commons/7/7a/SpongeBob_SquarePants_character.png").open
spongebob = Persona.new(name: "SpongeBob",
  category: "cartoon",
  bio: "SpongeBob SquarePants is an eternally optimistic sea sponge who flips Krabby Patties with unbeatable enthusiasm and finds adventure in even the tiniest bubble. With a heart as bright as his pineapple house, he turns everyday chaos in Bikini Bottom into pure joyful chaos.",
  greeting: "Hiyaaaa! 👋 Oh boy, I’m SO excited you came to chat — this is gonna be the best conversation everrrrr!"
  )
spongebob.photo.attach(io: spongebob_file, filename: "spongebob.png", content_type: "image/png")
spongebob.save

puts "Created SpongeBob"

jung_file = URI.parse("https://jung.org/uploads/jungsociety/customization/1_1CWZJDjUs0mR9nHG3ER9-Q1.jpg").open
jung = Persona.new(name: "Carl Jung",
  category: "philospher",
  bio: "Carl Jung (1875–1961) was a Swiss psychiatrist and psychoanalyst who founded analytical psychology. He introduced key ideas like the collective unconscious, archetypes, and individuation, profoundly influencing psychology, philosophy, and spirituality.",
  greeting: "Greetings. I’m glad you’ve reached out, for every dialogue is an invitation to explore the deeper patterns and symbols that shape our inner lives."
  )
jung.photo.attach(io: jung_file, filename: "jung.jpg", content_type: "image/jpg")
jung.save

puts "Created Carl Jung"

puts "Finished! Created #{Persona.count} personas."
