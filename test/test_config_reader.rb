require File.expand_path('../helper', __FILE__)

class TestConfigReader < Test::Unit::TestCase
  test_presence ToPass::ConfigReader

  def test_config_reader_is_a_file_reader
    assert_kind_of ToPass::FileReader, instance
  end

  def test_can_load_config_file
    assert_not_nil klass.load('config')
  end

  def test_can_read_config_file
    assert_kind_of Hash, klass.load('config')
  end

  def test_default_algorithm_is_basic_de
    result = klass.load('config')[:algorithm]
    assert_not_nil result, 'the algorithm should be configured by default'
    assert_equal :basic_de, result
  end

  def test_default_pipe_out_behaviour_is_false
    result = klass.load('config')[:pipe_out]
    assert_not_nil result
    assert_equal false, result
  end
  def test_default_pipe_in_behaviour_is_false
    result = klass.load('config')[:pipe_in]
    assert_not_nil result
    assert_equal false, result
  end

  protected

  def klass
    ToPass::ConfigReader
  end
  def instance
    klass.new
  end
end
