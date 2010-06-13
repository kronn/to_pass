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

  def test_has_load_path
    assert_respond_to reader, :load_path
    assert_kind_of Array, reader.load_path
  end

  def test_load_path_contains_standard_dirs
    dirs = [
      '~/.to_pass/algorithms' ,
      "#{File.dirname(__FILE__)}/../lib/algorithms"
    ]

    Pathname.any_instance.expects(:exist?).times(dirs.size).returns(true)

    dirs.each do |reldir|
      dir = Pathname.new(reldir).expand_path
      assert( reader.load_path.include?(dir), "#{reader.load_path.inspect} should include #{dir.inspect}" )
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
