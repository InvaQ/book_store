class Book < ApplicationRecord
  has_many :pictures, as: :imageable
  has_many :reviews
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_and_belongs_to_many :authors
  has_many :line_items
  #has_many :orders, through: :line_items

  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  


  def get_author_names
    authors.collect {|author| author.name }.join(', ')
  end

  def get_book_dimensions
    "H:#{self.height}\" x W: #{self.width}\" x D: #{self.depth}\""
  end

  

end
