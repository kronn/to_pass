# vim:ft=ruby:fileencoding=utf-8

require 'test/unit'
require 'mocha'
require 'rbconfig'
require 'pathname'
require 'fileutils'

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
lib_path = File.expand_path('../../lib', __FILE__)
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
    dirs = []
    dirs << Pathname.new("#{user_dir}").expand_path # user
    dirs << "#{ruby_data_dir}/#{ToPass::APP_NAME}" # installed
    dirs << "#{File.dirname(__FILE__)}/../data/#{ToPass::APP_NAME}" if in_to_pass_soure_tree? # source [in github]

    dirs
  end

  def with_algorithm_in_user_dir
    FileUtils.mkpath("#{user_dir}/algorithms")

    safe_copy(
      "#{File.dirname(__FILE__)}/fixtures/user_alg.yml",
      "#{user_dir}/algorithms/user_alg.yml",
      &Proc.new
    )
  end

  def with_converters_in_user_dir
    FileUtils.mkpath("#{user_dir}/converters")

    safe_copy(
      "#{File.dirname(__FILE__)}/fixtures/user_converter.rb",
      "#{user_dir}/converters/userize.rb",
      &Proc.new
    )
  end

  def with_config_in_user_dir
    FileUtils.mkpath("#{user_dir}")

    safe_copy(
      "#{File.dirname(__FILE__)}/fixtures/user_config",
      "#{user_dir}/config",
      &Proc.new
    )
  end

  def without_config_user_dir
    FileUtils.mkpath("#{user_dir}")

    safe_copy(
      nil,
      "#{user_dir}/config",
      &Proc.new
    )
  end

  def safe_copy(source, target)
    begin
      target = File.expand_path(target)
      backup = "#{target}.backup"

      FileUtils.mv(target, backup) if File.exists?(target)
      FileUtils.cp(source, target) unless source.nil?

      yield

      FileUtils.rm(target) unless source.nil?
    ensure
      FileUtils.mv(backup, target) if File.exists?(backup)
    end
  end

  def in_to_pass_soure_tree?
    Pathname.new("#{File.dirname(__FILE__)}/../to_pass.gemspec").expand_path.exist?
  end

  def ruby_data_dir
    RbConfig::CONFIG['data-dir'] || RbConfig::CONFIG['datadir']
  end

  def user_dir
    ToPass::Directories[:user]
  end
end

unless Pathname.new("#{File.dirname(__FILE__)}/../to_pass.gemspec").expand_path.exist?
  $stderr << "Skipping some assertion as the tests run separated from the source-directory\n"
end

require 'to_pass'
