class PhotoUploader < CarrierWave::Uploader::Base

  # brings in the MiniMagick gem for photo resizing
  include CarrierWave::MiniMagick
  # helps with asset pipleine compatibility
  include Sprockets::Rails::Helper
  # changing the storagefrom local storage to the fog gem file
  # storage :file
  storage :fog

  # overrides the directory where uploaded files will be stored
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # creates different sizes of the photos uploaded
  version :tiny do
    process :resize_to_fill => [20,20]
  end

  version :profile_size do
    process :resize_to_fill => [300,300]
  end

  # version :full_size do
  #   process :resize_to_fill => [500,500]
  # end

  def extention_white_list
    %w(jpg jpeg gif png)
  end
end
