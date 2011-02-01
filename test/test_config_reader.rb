require File.expand_path('../helper', __FILE__)

class TestConfigReader < Test::Unit::TestCase
  test_presence ToPass::ConfigReader

  def test_config_reader_is_a_file_reader
    assert_kind_of ToPass::FileReader, instance
  end

  def test_can_load_config_file
    assert_not_nil klass.load
    assert_kind_of Hash, klass.load
  end

  protected

  def klass
    ToPass::ConfigReader
  end
  def instance
    klass.new
  end
end
