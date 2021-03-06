# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../lib/to_pass/version.rb', __FILE__)

spec = Gem::Specification.new do |s|
  s.name = ToPass::APP_NAME
  s.version = ToPass::VERSION
  s.date = ToPass::DATE
  s.summary = ToPass::SUMMARY
  s.description = ToPass::DESCRIPTION

  s.authors = ["Matthias Viehweger"]
  s.email = 'kronn@kronn.de'
  s.homepage = 'http://github.com/kronn/to_pass'
  s.rubyforge_project = '[none]' # to supress the warning

  s.require_paths = ["lib"]
  s.executables = ["password_of", "to_pass"]
  s.files = `git ls-files`.split("\n") - ['.gitignore']
  s.test_files = `git ls-files test`.split("\n")

  s.rdoc_options = ['--charset=utf-8', '--fmt=shtml', '--all', '--include=data/to_pass/converters/']
  s.extra_rdoc_files = ToPass::EXTRA_RDOC_FILES
  s.post_install_message = ToPass::RELEASE_NOTES


  # for tests, needed
  s.add_development_dependency 'rake'
  s.add_development_dependency 'mocha'

  # for release and doc generation, more less optional
  s.add_development_dependency 'rdoc', '>= 2.4.2'
  s.add_development_dependency 'ronn'
  s.add_development_dependency 'sdoc'
end
