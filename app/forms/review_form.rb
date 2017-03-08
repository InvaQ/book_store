class ReviewForm < Rectify::Form
  STR_ATTRS = [:title, :description, :state].freeze
  INT_ATTRS = [:rate, :book_id, :user_id].freeze

  STR_ATTRS.each { |str| attribute str, String }
  INT_ATTRS.each { |int| attribute int, Integer}

  validates :title, length: { maximum: 80 }
  validates :description, length: { maximum: 500 }
  validates :rate, numericality: { greater_than_or_equal_to: 1,
                                  less_than_or_equal_to: 5 }

end
