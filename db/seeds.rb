# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if User.create({ email: "admin@email.com", password: "asdasd", name: "admin", phone_number: "08123123123", address: "asdasd", level: "admin" })
  puts "add admin success"
else
  puts "add admin failed"
end

if Category.create([{ name: "Elektronik" }, { name: "Pakaian" }, { name: "Olah Raga" }])
  puts "success"
  puts "#{Category.count} Berhasil masuk"
else
  puts "gagal"
  puts "#{Category.count} Gagal masuk"
end
