# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require File.dirname(__FILE__)+'/helper'

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
    # digest = "#{MD5.hexdigest(string)}#{MD5.hexdigest(string).reverse}"
    # 1.upto(digest.length / 2).map { |nr| digest[(nr*2-2),2] }.map { |pair| pair.to_i(16).chr }.map { |char| char if char =~ /\w/i }.compact.join
    assert_converter 'testkFsNoKrb87d', { 'expand_below' => 5 }, 'test'
    assert_converter 'testtest', { 'expand_below' => 5 }, 'testtest'
  end

  def test_reverse
    assert_converter 'tset', 'reverse', 'test'
  end

  protected

  def assert_converter(expected, rule, string = 'test')
    assert_nothing_raised LoadError do
      result = converter.send(:apply_rule, string, rule)
      assert_equal expected, result, "Converter '#{rule.inspect}' should convert #{string} to #{expected}."
    end
  end

  def converter
    ToPass::Converter.new({})
  end
end
