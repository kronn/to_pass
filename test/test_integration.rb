require File.dirname(__FILE__)+'/helper'

class TestIntegration < Test::Unit::TestCase
  def test_cli_usage_without_algorithm
    assert_nothing_raised do
      assert_equal "t35t", `bin/to_pass test`.chomp
    end
  end

  def test_cli_usage_with_algorithm
    assert_nothing_raised do
      assert_equal "ti1p4u2", `bin/to_pass 'there is one problem for us, too' -a basic_en`.chomp
    end
  end

  def test_cli_usage_with_pipes
    assert_nothing_raised do
      assert_equal 't35t', `echo "test" | bin/to_pass`
    end
  end

  def test_module_integration
    assert_nothing_raised do
      str = "test"
      str.instance_eval "class << self; include ToPass::Integration; end"

      assert_equal 't35t', str.to_pass
    end
  end

  def test_cli_usage_with_user_algorithm
    with_algorithm_in_user_dir do
      assert_equal "le1/2%z", `bin/to_pass 'leasbpc' -a user_alg`.chomp
      assert_equal "le1/2%z", `bin/to_pass 'luke eats all sausagages because peter cries' -a user_alg`.chomp
    end
  end
end
