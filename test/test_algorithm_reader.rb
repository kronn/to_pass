# vim:ft=ruby:fileencoding=utf-8

require File.dirname(__FILE__)+'/helper'

class TestAlgorithmReader < Test::Unit::TestCase
  test_presence ToPass::AlgorithmReader

  def test_initialize
    assert_nothing_raised do
      klass.new( :basic_de )
    end
  end

  def test_load
    assert_respond_to klass, :load
    assert_kind_of Hash, klass.load(:basic_de)
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
    dirs = standard_directories.map { |path| "#{path}/algorithms"}

    Pathname.any_instance.expects(:exist?).times(dirs.size).returns(true)

    dirs.each do |reldir|
      dir = Pathname.new(reldir).expand_path
      assert( reader.load_path.include?(dir), "#{reader.load_path.inspect} should include #{dir.inspect}" )
    end
  end

  def test_loads_from_user_dir
    with_algorithm_in_user_dir do
      assert_kind_of Hash, klass.load(:user_alg)
    end
  end

  protected

  def klass
    ToPass::AlgorithmReader
  end
  def reader(algorithm = :basic_de)
    @reader ||= klass.new(algorithm)
  end
end
