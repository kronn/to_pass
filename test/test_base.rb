# vim:ft=ruby:fileencoding=utf-8

require File.dirname(__FILE__)+'/helper'

class TestBase < Test::Unit::TestCase
  test_presence ToPass::Base

  def test_usage
    assert_nothing_raised do
      pwd = ToPass::Base.new("Da steht ein Pferd auf dem Flur", 'basic_de').to_s
      assert_equal "Ds1P@dF", pwd
    end
  end

  def test_version
    assert_equal Pathname.new("#{File.dirname(__FILE__)}/../VERSION").expand_path.read.chomp, ToPass::VERSION
  end

  def test_date
    assert_equal Pathname.new("#{File.dirname(__FILE__)}/../VERSION").expand_path.mtime, ToPass::DATE
  end

  def test_appname
    assert_equal "to_pass", ToPass::APP_NAME
  end

  def test_gemspec_is_valid
    assert_nothing_raised do
      assert eval(Pathname.new("#{File.dirname(__FILE__)}/../to_pass.gemspec").expand_path.read).validate
    end
  end

  def test_directories
    dirs = ToPass::Directories

    assert defined?(dirs)
    assert_respond_to dirs, :[]

    assert_equal '~/.to_pass', dirs[:user]
    assert_equal "#{RbConfig::CONFIG['data-dir']}/#{ToPass::APP_NAME}", dirs[:data]
    assert_equal Pathname.new("#{File.dirname(__FILE__)}/../").expand_path.to_s, dirs[:base]
    assert_equal Pathname.new("#{File.dirname(__FILE__)}/../data/#{ToPass::APP_NAME}").expand_path.to_s, dirs[:source_data]

    assert_equal [ dirs[:user], dirs[:data], dirs[:source_data] ], dirs[:standard]
  end
end
