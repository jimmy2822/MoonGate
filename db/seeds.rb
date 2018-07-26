# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == "development"
    500.times do |fake|
      Gate.create!(:name => Faker::Lorem.word , :intro => Faker::Lorem.sentence(20, true),:intro_detail => Faker::Lorem.sentence(150, true), user_id:1 , server:"463954073876692992",:tag => Faker::Food.dish, is_public:"1" )
    end
end

