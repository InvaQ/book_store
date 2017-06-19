class Book < ApplicationRecord
  has_many :pictures, as: :imageable
  has_many :reviews, dependent: :destroy
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_and_belongs_to_many :authors
  has_many :line_items
  #has_many :orders, through: :line_items

  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  

  SORT_FILTERS = {newest: "Newest first", title_asc: "A - Z", title_desc: "Z - A", 
                low_price: "Price: low to high", high_price: "Price: high to low", popular: "Populat first"}.freeze

  scope :newest, -> { order(created_at: :desc) }
  scope :title_asc, -> { order(title: :asc) }
  scope :title_desc, -> { order(title: :desc) }
  scope :popular, -> { joins('LEFT JOIN line_items ON line_items.book_id = books.id')
                        .group('books.id').order('count(line_items.book_id) desc')}
  scope :low_price, -> { order(price: :asc) }
  scope :high_price, -> { order(price: :desc) }

  def get_author_names
    authors.map {|author| author.name }.join(', ')
  end

  def get_book_dimensions
    "H:#{self.height}\" x W: #{self.width}\" x D: #{self.depth}\""
  end

  def main_picture
    pictures[0].image_url || ImageUploader.new.default_url
  end

end
