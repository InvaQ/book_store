# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[Book,Author, Picture, Category].each do |klass|
  klass.delete_all
end




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

#Author.create!(first_name: 'Vitaly',last_name: 'Friedman')
#Author.create!(first_name: 'Daniel ',last_name: 'Mall')
#Author.create!(first_name: 'Gayle',last_name: 'Laakmann')
#Author.create!(first_name: 'McDowell',last_name: 'Rusk')
#Author.create!(first_name: 'Mark',last_name: 'Lutz')
#Author.create!(first_name: 'Steve',last_name: 'McConnell')
#Picture.create!(image_url: '1.jpg', imageable_type: 'book')
#Picture.create!(image_url: '2.jpg', imageable_type: 'book')
#Picture.create!(image_url: '3.jpg', imageable_type: 'book')
#Picture.create!(image_url: '4.jpg', imageable_type: 'book')
#Picture.create!(image_url: '5.jpg', imageable_type: 'book')
#Picture.create!(image_url: '6.jpg', imageable_type: 'book')
#Picture.create!(image_url: '7.png', imageable_type: 'book')
#Picture.create!(image_url: '8.png', imageable_type: 'book')
#Picture.create!(image_url: '9.png', imageable_type: 'book')
#Picture.create!(image_url: '10.jpg', imageable_type: 'book')
#Picture.create!(image_url: '11.jpg', imageable_type: 'book')
#Picture.create!(image_url: '12.jpg', imageable_type: 'book')
