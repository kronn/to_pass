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

  def test_cli_handles_wrong_arguments
    # i only want to check the return value here
    system("#{binpath}to_pass 'test' --schnulli >/dev/null 2>/dev/null")
    to_pass = $?

    assert to_pass.exited?
    assert_equal 0, to_pass.exitstatus, 'should have exit code 0 (success)'
  end

  def test_cli_presents_help_on_error
    # combine everything into result-string
    result = `#{binpath}to_pass "test" --schnulli 2>&1`

    assert_match /Usage/, result, 'should print usage information'
    assert_match /Show this message/, result, 'should contain hint for help'
  end

  protected

  def binpath
    bin_to_pass = File.expand_path('../../bin/to_pass', __FILE__)
    if File.exist?(bin_to_pass)
      File.dirname(bin_to_pass)
    else
      File.dirname(`which -a to_pass`.split.uniq.reject { |p| p =~ /gems/ }.first)
    end + '/'
  end
end
