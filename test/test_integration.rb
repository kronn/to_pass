require File.dirname(__FILE__)+'/helper'

class TestIntegration < Test::Unit::TestCase
  def test_cli_usage_without_algorithm
    assert_nothing_raised do
      assert_equal "t35t", `bin/to_pwd test`.chomp
    end
  end

  def test_cli_usage_with_algorithm
    assert_nothing_raised do
      assert_equal "ti1p4u2", `bin/to_pwd 'there is one problem for us, too' -a basic_en`.chomp
    end
  end

  def test_cli_usage_with_pipes
    assert_nothing_raised do
      assert_equal 't35t', `echo "test" | bin/to_pwd`
    end
  end

  def test_module_integration
    assert_nothing_raised do
      str = "test"
      str.instance_eval "class << self; include ToPwd::Integration; end"

      assert_equal 't35t', str.to_pwd
    end
  end
end
