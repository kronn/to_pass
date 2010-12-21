# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../helper', __FILE__)

class TestFileReader < Test::Unit::TestCase
  test_presence ToPass::FileReader

  def test_initialize
    assert_nothing_raised do
      klass.new
    end
  end

  def test_load
    assert_respond_to klass, :load
    assert_not_nil klass.load('config')
  end

  def test_discover
    assert_respond_to klass, :discover
    assert_kind_of Array, klass.discover
  end

  def test_has_load_path
    assert_respond_to reader, :load_path
    assert_kind_of Array, reader.load_path
  end

  def test_load_path_contains_standard_dirs
    dirs = standard_directories.map { |path| "#{path}#{concern}"}

    Pathname.any_instance.expects(:exist?).at_least(dirs.size).returns(true)

    dirs.each do |reldir|
      dir = Pathname.new(reldir).expand_path
      assert_include dir, reader.load_path
    end
  end

  protected

  def concern
    ''
  end
  def klass
    ToPass::FileReader
  end
  def reader
    @reader ||= klass.new
  end
end
