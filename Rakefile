# vim:ft=ruby:fileencoding=utf-8

# # enable trace to get better error output
# Rake.application.options.trace = true

# documentation tasks
begin
  %w[ rake/rdoctask sdoc ].each { |lib| require lib }
  Rake::RDocTask.new do |rdoc|
    require File.expand_path('../lib/to_pass/version', __FILE__)

    rdoc.rdoc_dir = 'doc/rdoc'
    rdoc.title = "#{ToPass::APP_NAME} #{ToPass::VERSION}"
    rdoc.options << '--fmt=shtml'
    rdoc.options << '--all'
    rdoc.options << '--charset=utf-8'
    rdoc.template = 'direct'

    rdoc.rdoc_files.include('README*')
    rdoc.rdoc_files.include('LICENSE')
    rdoc.rdoc_files.include('TODO')
    rdoc.rdoc_files.include('lib/**/*.rb')
    rdoc.rdoc_files.include('data/**/*.rb')
  end
rescue LoadError
end
begin
  desc 'generate manpages for project'
  task :man do
    [1,5].each do |section|
      files = Dir["./man/*#{section}.ronn"]
      `ronn --html --roff --style=toc #{files.join(' ')}`
      target_dir = "./man/man#{section}/"
      FileUtils.mkdir_p target_dir
      FileUtils.mv Dir["./man/*.#{section}.html"], target_dir
      FileUtils.mv Dir["./man/*.#{section}"], target_dir
    end
  end
end

desc "run tests"
task :test do
  require File.expand_path('../test/all', __FILE__)
end

desc "list available algorithms"
task :algorithms, :needs => [:to_pass] do
  puts ""
  puts "  available password algorithms"
  puts "  ============================================"
  ToPass::AlgorithmReader.discover.each do |algorithm|
    puts "  - #{algorithm}"
  end
  puts "  ============================================"
  puts ""
end

desc "list available converters"
task :converters, :needs => [:to_pass] do
  puts ""
  puts "  available converters for password algorithms"
  puts "  ============================================"
  ToPass::ConverterReader.new.discover.each do |converter|
    puts "  - #{converter}"
  end
  puts "  ============================================"
  puts ""
end

task :to_pass do
  require File.expand_path('../lib/to_pass', __FILE__)
end

task :default => :test
