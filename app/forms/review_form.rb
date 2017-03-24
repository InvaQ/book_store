class ReviewForm < Rectify::Form
  STR_ATTRS = [:title, :description].freeze

  STR_ATTRS.each do |str| 
    attribute str, String 
    validates str, presence: true
  end
 
  attribute :rate, Integer
  validates :rate, presence: true
 

  validates :title, length: { maximum: 80 }
  validates :description, length: { maximum: 500 }
  validates :rate, numericality: { greater_than_or_equal_to: 1,
                                  less_than_or_equal_to: 5 }

end
