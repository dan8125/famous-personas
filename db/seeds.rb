# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "Cleaning database..."

User.destroy_all
puts "Creating users..."
haruna = User.create!(email: "haruna@gmail.com", password: "123456")
steve = User.create!(email: "steve@gmail.com", password: "123456")
dan = User.create!(email: "dan@gmail.com", password: "123456")
puts "Created users."

Persona.destroy_all
puts "Creating personas..."
Persona.create!(name: "Queen Elizabeth", category: "historical person")
puts "Created Queen Elizabeth"
Persona.create!(name: "Spongebob", category: "cartoon")
puts "Created Spongebob"

puts "Finished! Created #{Persona.count} personas."
