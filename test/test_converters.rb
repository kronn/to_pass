# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require File.dirname(__FILE__)+'/helper'

class TestConverters < Test::Unit::TestCase
  def test_presence
    assert_module_defined ToPass::Converters
  end
end
