# vim:ft=ruby:fileencoding=utf-8

require 'test/unit'
require 'mocha'
require 'rbconfig'
require 'pathname'

# optional libraries
begin
  require 'redgreen'
rescue LoadError
end

begin
  require 'test_benchmark' if ENV['BENCHMARK']
rescue LoadError
end

# setup the LoadPath
lib_path = File.expand_path('../lib', __FILE__)
if File.exist?(lib_path)
  $LOAD_PATH << lib_path unless $LOAD_PATH.include?(lib_path)
end

Test::Unit::TestCase.class_eval do
  def assert_class_defined(klass)
    assert defined?(klass), "#{klass} should be defined"
    assert_kind_of Class, klass, "#{klass} should be a class"
  end

  def assert_module_defined(modul)
    assert defined?(modul), "#{modul} should be defined"
    assert_kind_of Module, modul, "#{modul} should be a module"
  end

  def self.test_presence(klass)
    define_method "test_presence" do
      assert_class_defined klass
    end
  end

  def assert_include(needle, haystack, msg = nil)
    msg ||= "#{haystack.inspect} should include #{needle.inspect}"
    assert haystack.include?(needle), msg
  end

  def standard_directories
    dirs = [
      '~/.to_pass' , # user
      "#{RbConfig::CONFIG['data-dir']}/#{ToPass::APP_NAME}", # installed
    ]

    dirs << "#{File.dirname(__FILE__)}/../data/#{ToPass::APP_NAME}" if in_to_pass_source_tree? # source [in github]

    dirs
  end

  def in_to_pass_source_tree?
    Pathname.new("#{File.dirname(__FILE__)}/../to_pass.gemspec").expand_path.exist?
  end

  def with_algorithm_in_user_dir
    `mkdir -p ~/.to_pass/algorithms; cp -f #{File.dirname(__FILE__)}/fixtures/user_alg.yml ~/.to_pass/algorithms/user_alg.yml`
    yield
    `rm ~/.to_pass/algorithms/user_alg.yml`
  end

  def with_converters_in_user_dir
    `mkdir -p ~/.to_pass/converters; cp -f #{File.dirname(__FILE__)}/fixtures/user_converter.rb ~/.to_pass/converters/userize.rb`
    yield
    `rm ~/.to_pass/converters/userize.rb`
  end

end

require 'to_pass'

unless Pathname.new("#{File.dirname(__FILE__)}/../to_pass.gemspec").expand_path.exist?
  $stderr << "Skipping some assertion as the tests run separated from the source-directory\n"
end
