# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[Book,Author, Picture, Category, Country, User].each do |klass|
  klass.delete_all
end

User.create!(email: 'admin@test.com', password: 'testtest')
User.create!(email: 'user@test.com', password: 'testtest')


Book.create!(title: 'Real-Life Responsive Web Design', description: 'Smart front-end techniques and design 
  patterns derived from real-life responsive projects', height: 12, width: 10, depth: 10, publication: 2011, price: 49.55, materials: 'Hardcove, glossy paper')

Book.create!(title: 'Learning Python, 5th Edition', description: 'techniques and design 
  patterns derived from real-life responsive projects', height: 10, width: 19, depth: 11, publication: 2017, price: 47.75, materials: 'Hardcove, glossy paper')

Book.create!(title: 'The Self-Taught Programmer', description: 'Smart front-end ', height: 9, width: 9, depth: 9, publication: 2001, price: 49.99, materials: 'Hardcove, glossy paper')

Book.create!(title: '1111', description: '11', height: 12, width: 15, depth: 10, publication: 1998, price: 1.00, materials: 'Hardcove, glossy paper')

Book.create!(title: '222222', description: '2', height: 12, width: 15, depth: 10, publication: 1998, price: 2.00, materials: 'Hardcove, glossy paper')

Book.create!(title: '33333', description: '2', height: 12, width: 15, depth: 10, publication: 1998, price: 3.00, materials: 'Hardcove, glossy paper')
Category.create!(name: 'Mobile Development')
Category.create!(name: 'Photo')
Category.create!(name: 'Web Design')


Book.all.each_with_index do |book, index|
  
  book.authors.create!(first_name: 'Vitaly',last_name: 'Friedman')
  book.pictures.create!(image_url: "#{index+1}.jpg")
  3.times do
  book.pictures.create!(image_url: "22.jpg")
  end
  book.categories << Category.first if index.even?    
end

{'USA': '123', 'Ukraine': '124', 'Germany': '125', 'Malta': '126',
             "Australia": '127', 'Russia': '128', 'Japan': '129'}.each do |name, code|
  Country.create!(name: name, code: code)
end