# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
  
   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  process :scale => [200, 300]
  
  def scale(width, height)
   # do something
  end

  version :thumb do
   process :resize_to_fit => [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
   "something.jpg" if original_filename
  end

end
