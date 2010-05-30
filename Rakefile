# optional libraries
%w[ redgreen ].each do |lib|
  begin
    require lib
  rescue LoadError
  end
end

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
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# begin
#   require 'rcov/rcovtask'
#   Rcov::RcovTask.new do |test|
#     test.libs << 'test'
#     test.pattern = 'test/**/test_*.rb'
#     test.verbose = true
#   end
# rescue LoadError
#   task :rcov do
#     abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
#   end
# end

# require 'rake/rdoctask'
# Rake::RDocTask.new do |rdoc|
#   version = File.exist?('VERSION') ? File.read('VERSION') : ""
#
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "to_pwd #{version}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end

task :test, :needs => [:check_dependencies] do
  ( ['test/unit', 'test/helper'] + Dir['test/test_*.rb'] ).each do |file|
    require file
  end
end

task :default => :test

# # enable trace to get better error output
# Rake.application.options.trace = true
