class ImageUploader < CarrierWave::Uploader::Base

   include CarrierWave::MiniMagick
   # process resize_to_limit: [300, 300]
   process convert: 'jpg'
  
  if Rails.env.production?
    storage :dropbox
  else
    storage :file
  end
 
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  
   def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
   end

  version :main do
    process resize_to_fit: [700,400]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

 

end
