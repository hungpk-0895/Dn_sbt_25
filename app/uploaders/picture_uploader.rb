class PictureUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]

  # Choose what kind of storage to use for this uploader:
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url *_args
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path("fallback/"
    # + [version_name, "default.png"].compact.join('_'))

    "/assets/fallback/" + [version_name, "default.jpg"].compact.join("_")
  end
end
