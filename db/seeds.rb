User.create!(name: "Spawnk",
  email: "test@test.fr",
  password: "azerty",
  password_confirmation: "azerty",
  admin:true)

  99.times do |n|
    nom = Faker::Name.name
    email = "test#{n + 1}@test.fr"
    password = "azerty"
    User.create!(name: nom,
      email: email,
      password: password,
      password_confirmation: password)
    end
