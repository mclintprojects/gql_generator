Gem::Specification.new do |s|
  s.name        = "gql_generator"
  s.version     = "0.1"
  s.platform    = "ruby"
  s.authors     = ["Clinton Mbah"]
  s.email       = ["clintonmbah44@gmail.com"]
  s.homepage    = "https://github.com/mclintproject/gql-generator"
  s.summary     = "A better Rails generator for GraphQL Ruby."
  s.description = "This generator will create types, mutations and their respective test files for you."
  s.files = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
  s.add_development_dependency 'rails', '~> 6.0'
end