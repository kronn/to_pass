# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require File.dirname(__FILE__)+'/helper'

class TestAlgorithms < Test::Unit::TestCase
  def test_basic_de
    assert_algorithm 't35t', 'test', :basic_de
    assert_algorithm 'Ds1P@dF', 'Da steht ein Pferd auf dem Flur', :basic_de
  end

  def test_basic_en
    assert_algorithm "t35t", 'test', :basic_en
    assert_algorithm "ti1p4u2", 'there is one problem for us, too', :basic_en
  end

  def test_secure
    assert_algorithm '$78bRkT5eT0n5Fk', 'test', :secure
    assert_algorithm '5P2fWb2Cm0Wf%$5', 'my cat is cute', :secure
  end

  protected

  def assert_algorithm(expected, input, algorithm)
    assert_nothing_raised do
      pwd = ToPass::Base.new(input, algorithm).to_s
      assert_equal expected, pwd
    end
  end
end
