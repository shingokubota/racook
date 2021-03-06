class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    "/images/" + [version_name, "default.png"].compact.join('_')
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  # 詳細表示用 400 * 400の正方形に整形
  version :thumb400 do
    process resize_and_pad(400, 400, background = :transparent, gravity = 'Center')
  end
  # 一覧表示用 200 * 200の正方形に中央から切り抜き
  version :thumb200 do
    process resize_to_fill: [200, 200, 'Center']
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
