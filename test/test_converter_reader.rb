# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../helper', __FILE__)

class TestConverterReader < Test::Unit::TestCase
  test_presence ToPass::ConverterReader

  def test_load
    assert_respond_to reader, :load
    assert_kind_of Class, reader.load(:replace)
  end

  def test_discover
    assert_respond_to reader, :discover
    assert_kind_of Array, reader.discover
  end

  def test_has_load_path
    assert_respond_to reader, :load_path
    assert_kind_of Array, reader.load_path
  end

  def test_knows_loaded_converters
    assert_respond_to reader, :loaded
    assert_kind_of Array, reader.loaded
    assert_equal 0, reader.loaded.size

    reader.load(:replace)
    reader.load(:first_chars)

    assert_equal 2, reader.loaded.size
    assert_equal :replace, reader.loaded.first
  end

  def test_load_path_contains_standard_dirs
    dirs = standard_directories.map { |path| "#{path}/converters"}

    Pathname.any_instance.expects(:exist?).at_least(dirs.size).returns(true)

    dirs.each do |reldir|
      dir = Pathname.new(reldir).expand_path
      assert_include dir, reader.load_path
    end
  end

  def test_loads_from_user_dir
    with_converters_in_user_dir do
      assert_kind_of Class, reader.load(:userize), "Converter 'Userize' should have been found"
    end
  end

  protected

  def klass
    ToPass::ConverterReader
  end
  def reader
    @reader ||= klass.new
  end
end
