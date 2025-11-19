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

User.destroy_all
puts "Creating users..."
haruna = User.create!(email: "haruna@gmail.com", password: "123456")
steve = User.create!(email: "steve@gmail.com", password: "123456")
dan = User.create!(email: "dan@gmail.com", password: "123456")
puts "Created users."

Persona.destroy_all
puts "Creating personas..."
elizabeth_file = URI.parse("https://assets.vogue.com/photos/5f6d05918c75f02cb3917f28/16:9/w_1920%2Cc_limit/fp111_107a_her_majesty_queen_elizabeth_xl_02618_2008131904_id_1316166.jpg").open
elizabeth = Persona.new(name: "Queen Elizabeth", category: "historical person", bio: "Queen Elizabeth II (1926–2022) was the longest-reigning British monarch, known for her dedication, resilience, and service. She guided the UK and Commonwealth through decades of change, becoming a symbol of stability and continuity.")
elizabeth.photo.attach(io: elizabeth_file, filename: "elizabeth.jpg", content_type: "image/jpg")
elizabeth.save

puts "Created Queen Elizabeth"

spongebob_file = URI.parse("https://ih1.redbubble.net/image.5393571504.5746/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg").open
spongebob = Persona.new(name: "Spongebob", category: "cartoon", bio: "SpongeBob SquarePants is a cheerful, optimistic sea sponge living in Bikini Bottom. He works at the Krusty Krab, loves jellyfishing, and embraces life with boundless energy, curiosity, and a knack for getting into quirky, fun-filled adventures with his friends.")
spongebob.photo.attach(io: spongebob_file, filename: "spongebob.jpg", content_type: "image/jpg")
spongebob.save

puts "Created Spongebob"


jung_file = URI.parse("https://jung.org/uploads/jungsociety/customization/1_1CWZJDjUs0mR9nHG3ER9-Q1.jpg").open
jung = Persona.new(name: "Carl Jung", category: "philospher", bio: "Carl Jung (1875–1961) was a Swiss psychiatrist and psychoanalyst who founded analytical psychology. He introduced key ideas like the collective unconscious, archetypes, and individuation, profoundly influencing psychology, philosophy, and spirituality.")
jung.photo.attach(io: jung_file, filename: "jung.jpg", content_type: "image/jpg")
jung.save

puts "Created Carl Jung"

puts "Finished! Created #{Persona.count} personas."
