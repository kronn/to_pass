# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

# jeweler task
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "to_pwd"
    gem.summary = "generate password from words or sentences"
    gem.description = %Q{Passwords should be easy to remember and hard to guess.
One technique is to have a sentence which can be easily remembered transformed to a password.}
    gem.email = "kronn@kronn.de"
    gem.homepage = "http://github.com/kronn/to_pwd"
    gem.authors = ["Matthias Viehweger"]

    gem.add_development_dependency 'mocha'
    gem.add_development_dependency 'sdoc'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# rcov task (commented out)
begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.test_files = FileList['test/test_*.rb']
    test.output_dir = "doc/rcov"
    test.verbose = true
    test.rcov_opts << [
      "--sort coverage",
      "--profile",
      "--include test",
      "--exclude /gems/,/Library/,spec"
    ].join(" ")
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install rcov"
  end
end

%w[ rake/rdoctask sdoc ].each { |lib| require lib }
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'doc/rdoc'
  rdoc.title = "to_pwd #{version}"
  rdoc.options << '--fmt' << 'shtml'
  rdoc.template = 'direct'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "run tests"
task :test, :needs => [:check_dependencies] do
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

# # enable trace to get better error output
# Rake.application.options.trace = true
