require File.dirname(__FILE__)+'/helper'

class TestConverter < Test::Unit::TestCase
  def teardown
    @converter = nil
  end

  # basic presence and api-testing
  def test_presence
    assert defined?(ToPwd)
    assert defined?(ToPwd::Converter)
  end
  def test_instantiation
    assert_nothing_raised do
      ToPwd::Converter.new({})
    end
  end
  def test_convert
    assert_respond_to converter, :convert
    assert_nothing_raised do
      converter.convert( "test" )
    end
  end

  # mock-tests to ensure presence and calling of internal methods
  def test_from_word
    assert_respond_to converter, :from_word
    converter.expects(:from_word).once

    converter.convert("test")
  end
  def test_from_sentence
    assert_respond_to converter, :from_sentence
    converter.expects(:from_sentence).once

    converter.convert("test test test")
  end
  def test_replace
    assert_respond_to converter, :replace
    converter.expects(:replace).once

    converter.convert("test")
  end
  def test_swapcase
    converter({'from_word' => ['swapcase']})
    assert_respond_to converter, :swapcase
    converter.expects(:swapcase).once
    converter.convert("test")
  end

  # actual result-testing
  def test_replacement
    result = converter.convert("test")
    assert_equal "t35t", result
  end
  def test_case_swapping
    converter({'from_word' => ['swapcase']})
    result = converter.convert("test")
    assert_equal "tEsT", result
  end
  def test_case_swapping_ignores_numbers
    converter({'from_word' => ['swapcase']})
    result = converter.convert("test4fun")
    assert_equal "tEsT4fUn", result
  end
  # def test_multiple_rules
  # end

  protected

  def converter(rules = basic_rules)
    @converter ||= ToPwd::Converter.new(rules)
  end

  def basic_rules
    {
      'from_word' => [{ 'table' => 'special' }],
      'tables' => {
        'special' => {
          'e' => '3',
          's' => '5'
        }
      }
    }
  end
end
