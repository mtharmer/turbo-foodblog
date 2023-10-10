# frozen_string_literal: true

require 'image_processing/mini_magick'

class ImageUploader < Shrine
  plugin :derivation_endpoint, prefix: 'derivations/image', secret_key: 'tbofbo' # matches mount point

  derivation :thumbnail do |file, width, height|
    ImageProcessing::MiniMagick
      .source(file)
      .crop!("#{width}x#{height}+0+0")
      .resize_to_limit!(width.to_i, height.to_i)
  end
end
