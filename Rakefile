# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

# # enable trace to get better error output
# Rake.application.options.trace = true

# documentation tasks
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
begin
  desc 'generate manpages for project'
  task :man do
    files = Dir['./man/*.ronn'].join(' ')
    command = "ronn --html --roff --style=toc #{files}"

    `#{command}`
  end
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
  require 'lib/to_pass'
end

task :default => :test
