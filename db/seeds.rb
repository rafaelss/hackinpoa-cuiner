User.connection.execute("TRUNCATE TABLE users")
Menu.connection.execute("TRUNCATE TABLE menus")

users = User.create!([
  { name: "Eduardo Costa", email: "eduardo@thelaborat.org", password: "aaa123", password_confirmation: "aaa123" },
  { name: "João de Freitas", email: "joaofranscisconeto@gmail.com", password: "aaa123", password_confirmation: "aaa123" },
  { name: "Rafael Souza", email: "rafael.ssouza@gmail.com", password: "aaa123", password_confirmation: "aaa123" }
])

menus = Menu.create!([
  { user_id: users[0].id, name: "Massa Carbonara", price: 10.99, price_per_person: 2.99, number_of_people: [2, 10], tags: ["bacon"] },
  { user_id: users[1].id, name: "Churrasco", price: 45, price_per_person: 10, number_of_people: [5, 20], tags: ["picanha", "costela", "maminha", "vazio"] },
  { user_id: users[2].id, name: "Comida Japonesa", price: 20, price_per_person: 20, number_of_people: [2, 5], tags: ["sushi", "sashimi"] }
])
