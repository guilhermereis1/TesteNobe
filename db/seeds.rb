if Rails.env.development? then
  User.find_or_create_by(
    name: "Guilherme Reis",
    cpf_or_cnpj: "02848154110",
    email: "gui@gmail.com",
    password: "123123",
    password_confirmation: "123123"
  )
elsif Rails.env.production? then
  User.find_or_create_by(
    name: "Guilherme Reis",
    cpf_or_cnpj: "02848154110",
    email: "gui@gmail.com",
    password: "123123",
    password_confirmation: "123123"
  )
end