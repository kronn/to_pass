require File.dirname(__FILE__)+'/helper'

class TestBase < Test::Unit::TestCase
  test_presence ToPwd::Base

  def test_usage
    assert_nothing_raised do
      pwd = ToPwd::Base.new("Da steht ein Pferd auf dem Flur", 'basic_de').to_s
      assert_equal "Ds1P@dF", pwd
    end
  end

  def test_version
    assert_equal Pathname.new("#{File.dirname(__FILE__)}/../VERSION").expand_path.read.chomp, ToPwd::VERSION
  end

  def test_appname
    assert_equal "to_pwd", ToPwd::APP_NAME
  end
end
