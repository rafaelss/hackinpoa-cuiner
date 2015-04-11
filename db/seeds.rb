# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.connection.execute("TRUNCATE TABLE users")

users = User.create!([
  { name: "Eduardo", email: "eduardo@thelaborat.org", password: "aaa123", password_confirmation: "aaa123" },
  { name: "João", email: "joaofranscisconeto@gmail.com", password: "aaa123", password_confirmation: "aaa123" },
  { name: "Rafael", email: "rafael.ssouza@gmail.com", password: "aaa123", password_confirmation: "aaa123" }
])

Menu.create([
  { user_id: users[0].id, name: "Pizza", price: 10.99, price_per_person: 2.99, number_of_people: (2..10) }
])
