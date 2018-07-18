# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10000.times do |fake|
    Gate.create!(:name => Faker::Lorem.words(3) , :intro => Faker::Lorem.sentence(20, true),user_id:1 ,server:"666",is_public:"1" )
end

