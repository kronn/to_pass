# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../helper', __FILE__)

class TestDirectories < Test::Unit::TestCase
  test_presence ToPass::Directories

  def test_directories
    assert_respond_to dirs, :[]

    assert_equal '~/.to_pass', dirs[:user]
    assert_equal "#{ruby_data_dir}/#{ToPass::APP_NAME}", dirs[:data]

    if in_to_pass_soure_tree?
      assert_equal Pathname.new("#{File.dirname(__FILE__)}/../").expand_path.to_s, dirs[:base]
      assert_equal Pathname.new("#{File.dirname(__FILE__)}/../data/#{ToPass::APP_NAME}").expand_path.to_s, dirs[:source_data]
    end

    assert_equal [ dirs[:user], dirs[:data], dirs[:source_data] ], dirs[:standard]
  end

  def test_directories_can_be_extended
    assert_respond_to dirs, :[]=

    new_dir = Pathname.new('/tmp/my_to_pass')

    assert_equal new_dir, ( dirs[:new] = new_dir )
    assert_include new_dir, dirs
    assert_equal new_dir, dirs[:new]

    assert_include new_dir, dirs[:all]
    assert_equal new_dir, dirs[:all].first
  end

  def test_directories_can_be_searched
    assert_respond_to dirs, :include?

    # assert_include(needle, haystack[, msg]) uses include? to verify.
    assert_include :user, dirs
    assert_include '~/.to_pass', dirs
  end

  protected

  def dirs
    ToPass::Directories
  end
end
