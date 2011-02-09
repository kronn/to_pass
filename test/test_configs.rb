# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../helper', __FILE__)

class TestConfigs < Test::Unit::TestCase
  def config
    @config ||= begin
                  @config = nil

                  without_config_user_dir do
                    @config = ToPass::ConfigReader.load('config')
                  end

                  @config
                end
  end

  def test_default_algorithm_is_secure
    result = config[:algorithm]

    assert_not_nil result, 'the algorithm should be configured by default'
    assert_equal :secure, result
  end
  def test_default_pipe_out_behaviour_is_false
    result = config[:pipe_out]

    assert_not_nil result
    assert_equal false, result
  end
  def test_default_pipe_in_behaviour_is_false
    result = config[:pipe_in]

    assert_not_nil result
    assert_equal false, result
  end
end
