# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../helper', __FILE__)

class TestCli < Test::Unit::TestCase
  test_presence ToPass::Cli

  def test_cli_usage_without_algorithm
    assert_nothing_raised do
      assert_equal "t35t", `#{binpath}to_pass test`.chomp
    end
  end

  def test_cli_usage_with_password_of
    assert_nothing_raised do
      assert_equal "t35t", `#{binpath}password_of test`.chomp
    end
  end

  def test_cli_usage_with_algorithm
    assert_nothing_raised do
      assert_equal "ti1p4u2", `#{binpath}to_pass 'there is one problem for us, too' -a basic_en`.chomp
    end
  end

  def test_cli_usage_with_pipes
    assert_nothing_raised do
      assert_equal 't35t', `echo "test" | #{binpath}to_pass`
    end
  end

  def test_cli_usage_with_pipe_input
    assert_nothing_raised do
      assert_equal 't35t', `echo "test" | #{binpath}to_pass --no-pipe`.chomp
    end
  end

  def test_cli_usage_with_pipe_output
    assert_nothing_raised do
      assert_equal 't35t', `#{binpath}to_pass test --pipe`
    end
  end


  def test_cli_usage_with_user_algorithm
    with_algorithm_in_user_dir do
      assert_equal "le1/2%z", `#{binpath}to_pass 'leasbpc' -a user_alg`.chomp
      assert_equal "le1/2%z", `#{binpath}to_pass 'luke eats all sausagages because peter cries' -a user_alg`.chomp
    end
  end

  def test_cli_usage_with_pipes_and_user_algorithm
    with_algorithm_in_user_dir do
      assert_equal "le1/2%z", `echo 'leasbpc' | #{binpath}to_pass -a user_alg`.chomp
      assert_equal "le1/2%z", `echo 'luke eats all sausagages because peter cries' | #{binpath}to_pass -a user_alg`.chomp
    end
  end

  protected

  def binpath
    if File.exist?(File.expand_path('../../bin/to_pass'))
      'bin/'
    else
      File.dirname(`which to_pass`) + '/'
    end
  end
end
