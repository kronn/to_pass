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

  # mock-tests to ensure presence and calling of protected methods
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
  def test_first_chars
    converter({'from_sentence' => ['first_chars']})
    assert_respond_to converter, :first_chars
    converter.expects(:first_chars).once
    converter.convert("test test")
  end
  def test_collapse_chars
    converter({'from_sentence' => ['collapse_chars']})
    assert_respond_to converter, :collapse_chars
    converter.expects(:collapse_chars).once
    converter.convert("test test")
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

    result = converter.convert("fun4test")
    assert_equal "fUn4TeSt", result
  end
  def test_char_collapsing
    converter({'from_sentence' => ['collapse_chars']})
    assert_equal( "abc", converter.convert("a b c"))
  end
  def test_select_first_chars
    converter({'from_sentence' => ['first_chars']})
    assert_equal( "t a t f t", converter.convert('test all the fucking time'))
  end

  # more complex/real-life setups
  def test_multiple_rules
    converter(basic_rules.merge({
      'from_word' => [{'table' => 'special'}, 'swapcase']
    }))

    assert_equal( "t35T", converter.convert('test'))
  end
  def test_sentence
    converter(complex_rules)
    assert_equal( "Ds1P@dF", converter.convert("Da steht ein Pferd auf dem Flur"))
  end

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
  def complex_rules
    {
      'from_sentence' => [{'table'=>'words'},'first_chars','collapse_chars',{'table'=>'symbols'}],
      'tables' => {
        'words' => { 'ein' => '1' },
        'symbols' => { 'a' => '@' }
      }
    }
  end
end
