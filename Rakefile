# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

# # enable trace to get better error output
# Rake.application.options.trace = true

# jeweler task
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "to_pass"
    gem.summary = "generate password from words or sentences"
    gem.description = %Q{Passwords should be easy to remember and hard to guess.
One technique is to have a sentence which can be easily remembered transformed to a password.}
    gem.email = "kronn@kronn.de"
    gem.homepage = "http://github.com/kronn/to_pass"
    gem.authors = ["Matthias Viehweger"]

    gem.add_development_dependency 'mocha'
    gem.add_development_dependency 'sdoc'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# documentation task
begin
  %w[ rake/rdoctask sdoc ].each { |lib| require lib }
  Rake::RDocTask.new do |rdoc|
    version = File.exist?('VERSION') ? File.read('VERSION') : ""

    rdoc.rdoc_dir = 'doc/rdoc'
    rdoc.title = "to_pass #{version}"
    rdoc.options << '--fmt' << 'shtml'
    rdoc.template = 'direct'
    rdoc.rdoc_files.include('README*')
    rdoc.rdoc_files.include('lib/**/*.rb')
  end
rescue LoadError
end

desc "run tests"
task :test do
  # optional libraries
  %w[ redgreen ].each do |lib|
    begin
      require lib
    rescue LoadError
    end
  end
  ( ['test/unit', 'test/helper'] + Dir['test/test_*.rb'] ).each do |file|
    require file
  end
end

task :default => :test
