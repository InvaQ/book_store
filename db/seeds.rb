# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[Book,Author, Picture, Category, Country, User, Coupon, Delivery].each do |klass|
  klass.delete_all
end

User.create!(email: 'admin@test.com', password: 'testtest')
User.create!(email: 'user@test.com', password: 'testtest')


15.times do
  Book.create!(title: FFaker::Book.title, description: FFaker::Book.description, height: 12, width: 10, depth: 10, publication: 2011, price: 49.55, materials: 'Hardcove, glossy paper')
end
Book.create!(title: 'Learning Python, 5th Edition', description: 'techniques and design 
  patterns derived from real-life responsive projects', height: 10, width: 19, depth: 11, publication: 2017, price: 47.75, materials: 'Hardcove, glossy paper')

Book.create!(title: 'The Self-Taught Programmer', description: 'Smart front-end ', height: 9, width: 9, depth: 9, publication: 2001, price: 49.99, materials: 'Hardcove, glossy paper')

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


['USA', 'Ukraine', 'Germany', 'Malta', "Australia", 'Russia', 'Japan'].each do |name|
  country = Country.create!(name: name)
  Delivery.create!(name: "#{name}_post") do |delivery|
    delivery.country = country
    delivery.price = rand(5..30)
    delivery.min_days = rand(2..7)
    delivery.max_days = rand(7..30)
  end
end
Coupon.create!(code: '123', discount: 50)
Coupon.create!(code: '1234', discount: 10)
