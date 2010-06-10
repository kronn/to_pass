require File.dirname(__FILE__)+'/helper'

class TestBase < Test::Unit::TestCase
  test_presence ToPwd::Base

  def test_usage
    assert_nothing_raised do
      pwd = ToPwd::Base.new("Da steht ein Pferd auf dem Flur", 'basic_de').to_s
      assert_equal "Ds1P@dF", pwd
    end
  end
end
