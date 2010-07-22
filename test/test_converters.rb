# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require File.dirname(__FILE__)+'/helper'

class TestConverters < Test::Unit::TestCase
  def test_presence
    assert_module_defined ToPass::Converters
  end

  def test_downcase
    assert_converter 'test', :downcase, 'tEsT'
  end

  def test_remove_repetition
    assert_converter 'helo', :remove_repetition, 'helo'
    assert_converter 'hel2o', :remove_repetition, 'hello'
    assert_converter 'hel3o', :remove_repetition, 'helllo'
  end

  protected

  def assert_converter(expected, rule, string = 'test')
    assert_nothing_raised LoadError do
      result = ToPass::Converter.new({}).send(:apply_rule, string, rule.to_s)
      assert_equal expected, result, "Converter '#{rule}' should convert #{string} to #{expected}."
    end
  end
end
