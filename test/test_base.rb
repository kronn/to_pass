# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require File.dirname(__FILE__)+'/helper'

class TestBase < Test::Unit::TestCase
  test_presence ToPass::Base

  def test_usage
    assert_nothing_raised do
      pwd = ToPass::Base.new("Da steht ein Pferd auf dem Flur", 'basic_de').to_s
      assert_equal "Ds1P@dF", pwd
    end
  end

  def test_version
    assert_equal Pathname.new("#{File.dirname(__FILE__)}/../VERSION").expand_path.read.chomp, ToPass::VERSION
  end

  def test_appname
    assert_equal "to_pass", ToPass::APP_NAME
  end
end
