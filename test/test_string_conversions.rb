require File.dirname(__FILE__)+'/helper'


class TestStringConversion < Test::Unit::TestCase
  def test_replacement
    result = converter.replace("test", {
      :e => 3,
      :s => 5
    })
    assert_equal "t35t", result
  end

  def test_case_swapping
    assert_equal "tEsT", converter.swapcase("test")
  end

  def test_case_swapping_ignores_numbers
    assert_equal "tEsT4fUn", converter.swapcase("test4fun")

    assert_equal "fUn4TeSt", converter.swapcase("fun4test")
  end

  def test_char_collapsing
    assert_equal "abc", converter.collapse_chars("a b c")
  end

  def test_select_first_chars
    assert_equal "t a t f t", converter.first_chars('test all the fucking time')
  end

  protected

  def converter
    klass = Class.new
    klass.send(:extend, ToPwd::StringConversions)
    klass
  end
end
