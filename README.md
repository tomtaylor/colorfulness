# Colorfulness

A Ruby library for calculating the colorfulness of an image, using a technique
described in ["Measuring colourfulness in natural images" (Hasler and
Susstrunk, 2003)][1] (See section 7: 'A More Efficient Metric').

It uses ChunkyPNG to read the pixels of an image, and expects to be passed
a ChunkyPNG `Image`.

For example:

```ruby
image = ChunkyPNG::Image.from_file(path)
calculator = Colorfulness::Calculator.new(image)
puts image.colorfulness
# 0.3207628365648987
```

[1]: http://infoscience.epfl.ch/record/33994/files/HaslerS03.pdf
