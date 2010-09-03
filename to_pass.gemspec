# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../lib/to_pass/version.rb', __FILE__)

spec = Gem::Specification.new do |s|
  s.name = ToPass::APP_NAME
  s.version = ToPass::VERSION
  s.date = ToPass::DATE

  s.authors = ["Matthias Viehweger"]
  s.email = 'kronn@kronn.de'
  s.homepage = 'http://github.com/kronn/to_pass'
  s.rubyforge_project = '[none]' # to supress the warning

  s.summary = 'generate password from words or sentences'
  s.description = <<-EOD
    Passwords should be easy to remember and hard to guess.
    One technique is to have a sentence which can be easily remembered transformed to a password.

    Pluggable algorithms and converters allow customization of the transformation process.
  EOD

  # s.required_ruby_version = '~> 1.8.7'

  s.require_paths = ["lib"]
  s.executables = ["password_of", "to_pass"]
  s.files = ["LICENSE", "README.rdoc", "TODO", "VERSION", "Rakefile", "Gemfile"] +
    `git ls-files {bin,lib,data,man,test}`.split("\n")
  s.test_files = `git ls-files test`.split("\n")

  s.has_rdoc = true
  s.rdoc_options = ["--charset=utf-8", '--fmt=shtml', '--all', '--include=data/to_pass/converters/']
  s.extra_rdoc_files = ["LICENSE", "README.rdoc", "TODO"]


  # for tests, needed
  s.add_development_dependency 'mocha'

  # for release and doc generation, more less optional
  s.add_development_dependency 'ronn'
  s.add_development_dependency 'gem-release'
  s.add_development_dependency 'sdoc'

  # # purely optional, for colored test-output
  # s.add_development_dependency 'redgreen'
end
