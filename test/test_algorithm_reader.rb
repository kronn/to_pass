require File.dirname(__FILE__)+'/helper'

class TestAlgorithmReader < Test::Unit::TestCase
  test_presence ToPwd::AlgorithmReader

  def test_initialize
    assert_nothing_raised do
      klass.new( :basic_de )
    end
  end

  def test_load
    assert_respond_to klass, :load
    assert_kind_of Hash, klass.load(:basic_de)
  end

  # def test_load_from_packaged_file
  #   assert_respond_to reader, :load_from_packaged_file
  #   assert_kind_of Hash, reader.load_from_packaged_file
  # end

  # def test_load_from_file
  #   assert_respond_to reader, :load_from_file
  # end

  protected

  def klass
    ToPwd::AlgorithmReader
  end
  def reader(algorithm = :basic_de)
    @reader ||= klass.new(algorithm)
  end
end
