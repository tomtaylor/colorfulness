$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "colorfulness"
  s.version     = "0.0.2"
  s.authors     = ["Tom Taylor"]
  s.email       = ["tom@tomtaylor.co.uk"]
  s.homepage    = "https://github.com/tomtaylor/colorfulness"
  s.summary     = "Ruby library to calculate the colorfulness of a ChunkyPNG Image"

  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.executables   = ["colorfulness"]

  s.add_dependency "chunky_png", '~> 1.2.9'
  s.add_dependency "oily_png", '~> 1.1.0'

  s.add_development_dependency "rake"
end
