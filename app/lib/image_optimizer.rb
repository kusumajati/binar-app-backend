# frozen_string_literal: true

require 'image_processing/mini_magick'

class ImageOptimizer
  class << self
    def resize_to_limit(content, width, height)
      ImageProcessing::MiniMagick
        .source(content)
        .resize_to_limit(width, height)
        .call
    end
  end
end
