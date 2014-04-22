require 'chunky_png'
require 'oily_png'

module Colorfulness
  class Calculator

    # Initialize the Calculator with a ChunkyPNG::Image, and an optional
    # background color to composite against, to remove the alpha component, if
    # any.
    def initialize(image, background_color = ChunkyPNG::Color::WHITE)
      @image = image
      @background_color = background_color
    end

    # Technique from https://gist.github.com/zabela/8539116, a MATLAB
    # implementation of the algorithm described in "Measuring colourfulness in
    # natural images" (Hasler and Susstrunk, 2003).
    def colorfulness
      rg = []
      yb = []

      (0...@image.width).each do |x|
        (0...@image.height).each do |y|
          # Gets the integer RGB value
          pixel = @image.get_pixel(x, y)
          # Compose the pixel against a background color to remove the alpha
          # component.
          flat_pixel = ChunkyPNG::Color.compose(pixel, @background_color)
          rgb = ChunkyPNG::Color.to_truecolor_bytes(flat_pixel)
          # Convert each component to float values between 0 and 1
          r, g, b = rgb.map { |c| c.to_f / ChunkyPNG::Color::MAX }

          rg << (r - g).abs
          yb << ((0.5 * (r + g)) - b).abs
        end
      end

      rg_std  = calculate_standard_deviation(rg)
      rg_mean = calculate_mean(rg)

      yb_std  = calculate_standard_deviation(yb)
      yb_mean = calculate_mean(yb)

      rg_yb_std = Math.sqrt(rg_std**2 + yb_std**2)
      rg_yb_mean = Math.sqrt(rg_mean**2 + yb_mean**2)

      rg_yb_std + (rg_yb_mean * 0.3)
    end

    private

    def calculate_standard_deviation(array)
      mean = calculate_mean(array)
      Math.sqrt(array.inject(0) { |sum,val| sum + (val - mean)**2 } / array.size)
    end

    def calculate_mean(array)
      array.inject(:+).to_f / array.size
    end

  end
end
