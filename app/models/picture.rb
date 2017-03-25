class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  mount_uploader :image_url, ImageUploader
  
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
end
