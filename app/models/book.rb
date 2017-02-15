class Book < ApplicationRecord
  has_many :pictures, as: :imageable
  has_many :reviews
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_and_belongs_to_many :authors

  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  


  def get_author_names
    self.authors.collect {|author| author.name }.join(', ')
  end

  def get_book_dimensions
    "H:#{self.height}\" x W: #{self.width}\" x D: #{self.depth}\""
  end
  #H:6.4\" x W: 0.9\" x D: 5.0
  #books.select('books.id, books.title, count(categorizations.id) as count').group('books.id, books.title')
end
