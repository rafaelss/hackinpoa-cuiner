User.all.map(&:destroy)

avatar = Cloudinary::Uploader.upload(Rails.root.join("design/imgs/banners/user_profile.jpg").to_s)

dudu = User.create!(
  name: "Eduardo Costa",
  email: "eduardo@thelaborat.org",
  password: "aaa123",
  password_confirmation: "aaa123",
  phone: "5187346543",
  photo_url: avatar["url"]
)

joao = User.create!(
  name: "João de Freitas",
  email: "joaofranscisconeto@gmail.com",
  password: "aaa123",
  password_confirmation: "aaa123",
  phone: "5198231234",
  photo_url: avatar["url"]
)

rafael = User.create!(
  name: "Rafael Souza",
  email: "rafael.ssouza@gmail.com",
  password: "aaa123",
  password_confirmation: "aaa123",
  phone: "5197234474",
  photo_url: avatar["url"]
)

dudu.menus.create!(
  name: "Massa Carbonara",
  price: 10.99,
  price_per_person: 2.99,
  number_of_people: [2, 10],
  tags: ["bacon"]
)

joao.menus.create!(
  name: "Churrasco",
  price: 45,
  price_per_person: 10,
  number_of_people: [5, 20],
  tags: ["picanha", "costela", "maminha", "vazio"]
)

rafael.menus.create!(
  name: "Comida Japonesa",
  price: 20,
  price_per_person: 20,
  number_of_people: [2, 5],
  tags: ["sushi", "sashimi"]
)

ap Menu.search("churras", numericFilters: ["price<=45"])
ap Menu.search("sushi", numericFilters: "max_number_of_people>=5")
