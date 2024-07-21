Gem::Specification.new do |spec|
  spec.name        = "player_hub"
  spec.version     = "1.0.0"
  spec.author      = "Daniel Cardenas"
  spec.email       = "eldanypalomo@gmail.com"
  spec.summary     = "An educational sample game project  from The pragmatic studio course"
  spec.homepage    = "https://github.com/danielpcar9/studio_game"
  spec.license     = "MIT"

  spec.files       = Dir["{bin,lib}/**/*"] + %w[LICENSE.txt README.md]
  spec.executables = ["studio_game"]

  spec.required_ruby_version = ">= 3.2.0"
end