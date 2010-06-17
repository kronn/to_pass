# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require File.dirname(__FILE__)+'/helper'

class TestIntegration < Test::Unit::TestCase
  def test_module_integration
    assert_nothing_raised do
      str = "test"
      str.instance_eval "class << self; include ToPass::Integration; end"

      assert_equal 't35t', str.to_pass
    end
  end
end
