# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../helper', __FILE__)

class TestConverters < Test::Unit::TestCase
  def test_presence
    assert_module_defined ToPass::Converters
  end

  def test_downcase
    assert_converter 'test', 'downcase', 'tEsT'
  end

  def test_remove_repetition
    assert_converter 'helo',  'remove_repetition', 'helo'
    assert_converter 'hel2o', 'remove_repetition', 'hello'
    assert_converter 'hel3o', 'remove_repetition', 'helllo'
  end

  def test_expand_below
    assert_converter 'kFsNotestKrb87d', { 'expand_below' => 5 }, 'test'
    assert_converter 'testtest', { 'expand_below' => 5 }, 'testtest'
  end

  def test_reverse
    assert_converter 'tset', 'reverse', 'test'
  end

  def test_replacement
    rules = {
      'replacements' => {
        'numbers' => {
          :e => 3,
          :s => 5
        }
      }
    }
    assert_converter 't35t', {'replace'=>'numbers'}, 'test', rules
  end

  def test_case_swapping
    assert_converter 'tEsT', 'swapcase', 'test'
  end

  def test_case_swapping_ignores_numbers
    assert_converter "tEsT4fUn", 'swapcase', "test4fun"
    assert_converter "fUn4TeSt", 'swapcase', "fun4test"
  end

  def test_char_collapsing
    assert_converter "abc", 'collapse_chars', "a b c"
  end

  def test_select_first_chars
    assert_converter "t a t f t", 'first_chars', "test all the fucking time"
  end

  protected

  def assert_converter(expected, rule, string = 'test', rules = {})
    assert_nothing_raised LoadError do
      result = ToPass::Converter.new(rules).send(:apply_rule, string, rule)
      assert_equal expected, result, "Converter '#{rule.inspect}' should convert #{string} to #{expected}."
    end
  end
end
