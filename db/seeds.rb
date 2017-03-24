require 'ffaker'

[LineItem, Book, Author, Picture, Category, Country, User, Coupon, Delivery ].each do |klass|
  klass.delete_all
end

User.create!(email: 'admin@test.com', password: 'Testtest00', admin: true)
User.create!(email: 'user@test.com', password: 'Testtest00')


40.times do
  Book.create!(title: FFaker::Book.title, description: FFaker::Book.description, 
    height: 12, width: 10, depth: 10, publication: rand(1999..2017), price: rand(1..30), materials: 'Hardcove, glossy paper')
end

Category.create!(name: 'Mobile Development')
Category.create!(name: 'Photo')
Category.create!(name: 'Web Design')


Book.all.each_with_index do |book, index|
  book.authors.create!(first_name: FFaker::Name.first_name,last_name: FFaker::Name.last_name)
  book.categories << Category.find(rand(1..3))   
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

