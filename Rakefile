# vim:ft=ruby:fileencoding=utf-8

# documentation tasks
begin
  desc 'rebuild documentation'
  task :doc do
    [:'documentation:rdoc', :'documentation:man'].each do |task_symbol|
      task = Rake::Task[task_symbol]
      task.invoke unless task.nil?
    end
  end
end

namespace :documentation do
  begin
    require 'sdoc'
  rescue LoadError
  end

  begin
    require 'rake/rdoctask'
    Rake::RDocTask.new() do |rdoc|
      require File.expand_path('../lib/to_pass/version', __FILE__)

      rdoc.rdoc_dir = 'doc/rdoc'
      rdoc.title = "#{ToPass::APP_NAME} #{ToPass::VERSION}"
      rdoc.options << '--fmt=shtml'
      rdoc.options << '--all'
      rdoc.options << '--charset=utf-8'
      rdoc.template = 'direct'

      ToPass::EXTRA_RDOC_FILES.each do |file|
        rdoc.rdoc_files.include(file)
      end
      rdoc.rdoc_files.include('lib/**/*.rb')
      rdoc.rdoc_files.include('data/**/*.rb')
    end
  rescue LoadError
  end

  begin
    require 'ronn'

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
  rescue LoadError
  end
end

desc "run tests"
task :test => :'test:normal'

namespace :test do
  task :normal do
    require File.expand_path('../test/all', __FILE__)
  end

  desc "run benchmarked tests"
  task :benchmark do
    ENV['BENCHMARK'] = 'yes'
    Rake::Task[:'test:normal'].invoke
  end

  desc "run tests from a separated directory"
  task :standalone do
    begin
      system('ruby ./setup.rb install')
      FileUtils.mkdir_p(stand_alone_test_path)
      FileUtils.cp_r('./test/.', stand_alone_test_path)
      FileUtils.cd(stand_alone_test_path) do
        STDOUT.sync = true
        system('ruby all.rb')
      end
    ensure
      FileUtils.rm_rf(stand_alone_test_path, :secure => true)
      system('ruby ./setup.rb uninstall')
    end
  end

  desc "run complete tests (for CI)"
  task :all do
    puts 'running normal testsuite'
    Rake::Task[:'test'].invoke
    # puts 'running standalone tests'
    # Rake::Task[:'test:stand_alone'].invoke

  def stand_alone_test_path
    './tmp/stand_alone_tests/'
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
  require File.expand_path('../lib/to_pass', __FILE__)
end

task :default => :test
