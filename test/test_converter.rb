# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../helper', __FILE__)

class TestConverter < Test::Unit::TestCase
  def teardown
    @converter = nil
  end

  # basic presence and api-testing
  test_presence ToPass::Converter
  def test_instantiation
    assert_nothing_raised do
      ToPass::Converter.new({})
    end
  end
  def test_convert
    assert_respond_to converter, :convert
    assert_nothing_raised do
      converter.convert( "test" )
    end
  end

  # mock-tests to ensure presence and calling of protected methods
  # the result-testing is done in test/test_converters.rb
  def test_replace
    assert_respond_to converter, :replace
    converter.expects(:apply_rule).with("test", {'replace'=>'special'}).once

    converter.convert("test")
  end
  def test_swapcase
    converter({'word' => ['swapcase']})
    assert_respond_to converter, :swapcase
    converter.expects(:apply_rule).with("test",  'swapcase' ).once
    converter.convert("test")
  end
  def test_first_chars
    converter({'sentence' => ['first_chars']})
    assert_respond_to converter, :first_chars
    converter.expects(:apply_rule).with("test test", 'first_chars').once
    converter.convert("test test")
  end
  def test_collapse_chars
    converter({'sentence' => ['collapse_chars']})
    assert_respond_to converter, :collapse_chars
    converter.expects(:apply_rule).with("test test", 'collapse_chars').once
    converter.convert("test test")
  end

  # more complex/real-life setups
  def test_multiple_rules
    converter(basic_rules.merge({
      'word' => [{'replace' => 'special'}, 'swapcase']
    }))

    assert_equal( "t35T", converter.convert('test'))
  end
  def test_sentence
    converter(complex_rules)
    assert_equal( "Ds1P@dF", converter.convert("Da steht ein Pferd auf dem Flur"))
  end
  def test_sentence_with_whitespace
    converter(complex_rules)
    assert_equal( "Ds1P@dF", converter.convert("Da	steht	ein

Pferd	auf	dem	Flur"))
  end

  protected

  def converter(rules = basic_rules)
    @converter ||= ToPass::Converter.new(rules)
  end

  def basic_rules
    {
      'word' => [{ 'replace' => 'special' }],
      'replacements' => {
        'special' => {
          'e' => '3',
          's' => '5'
        }
      }
    }
  end
  def complex_rules
    {
      'sentence' => [{'replace'=>'words'},'first_chars','collapse_chars',{'replace'=>'symbols'}],
      'replacements' => {
        'words' => { 'ein' => '1' },
        'symbols' => { 'a' => '@' }
      }
    }
  end
end
