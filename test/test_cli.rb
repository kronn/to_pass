# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../helper', __FILE__)

class TestCli < Test::Unit::TestCase
  test_presence ToPass::Cli

  def test_cli_usage_without_algorithm
    without_config_user_dir do
      assert_nothing_raised do
        assert_equal "$78bRkT5eT0n5Fk", `#{binpath}to_pass test`.chomp
      end
    end
  end

  def test_cli_usage_with_password_of
    without_config_user_dir do
      assert_nothing_raised do
        assert_equal "$78bRkT5eT0n5Fk", `#{binpath}password_of test`.chomp
      end
    end
  end

  def test_cli_usage_with_algorithm
    assert_nothing_raised do
      assert_equal "ti1p4u2", `#{binpath}to_pass 'there is one problem for us, too' -a basic_en`.chomp
    end
  end

  def test_cli_usage_with_pipes
    without_config_user_dir do
      assert_nothing_raised do
        assert_equal '$78bRkT5eT0n5Fk', `echo "test" | #{binpath}to_pass`
      end
    end
  end

  def test_cli_usage_with_pipe_input
    without_config_user_dir do
      assert_nothing_raised do
        assert_equal '$78bRkT5eT0n5Fk', `echo "test" | #{binpath}to_pass --no-pipe`.chomp
      end
    end
  end

  def test_cli_usage_with_pipe_output
    without_config_user_dir do
      assert_nothing_raised do
        assert_equal '$78bRkT5eT0n5Fk', `#{binpath}to_pass test --pipe`
      end
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

  def test_cli_usage_with_user_config
    with_algorithm_in_user_dir do
      with_config_in_user_dir do
        assert_equal "le1/2%z", `#{binpath}to_pass 'leasbpc'`.chomp
        assert_equal "le1/2%z", `#{binpath}to_pass 'luke eats all sausagages because peter cries'`.chomp
      end
    end
  end

  def test_configuration_path_is_configurable
    FileUtils.rm_r('/tmp/my_to_pass', :force => true, :secure => true)

    [
      `#{binpath}to_pass test -c /tmp/my_to_pass`,
      `#{binpath}to_pass test --config /tmp/my_to_pass`
    ].each do |result|
      assert_match /configuration path not found/, result, 'should output an errormessage'
      assert_match %r!to_pass --setup --config /tmp/my_to_pass!, result, 'should provide a hint how to fix it'
    end

    with_algorithm_in_user_dir('/tmp/my_to_pass') do
      assert_equal 'te/t', `#{binpath}to_pass test -c /tmp/my_to_pass -a user_alg`.chomp
    end
  end

  # def test_cli_has_setup_command
  #   result = `#{binpath}to_pass --setup --config /tmp/my_to_pass 2>&1`
  #
  #   assert path_not_present
  #   assert_match /successfully created configuration paths/i, result, 'should print success message'
  #   assert path_present
  # end

  def test_cli_can_output_algorithms
    algorithms = %w(basic_de basic_en secure)
    [
      `#{binpath}to_pass -A`,
      `#{binpath}to_pass --algorithms`
    ].each do |result|
      assert_match /available password algorithms/, result
      algorithms.each do |algorithm|
        assert_match /#{algorithm}/, result
      end
    end
  end

  def test_cli_can_output_converters
    converters = %w(collapse_chars downcase expand_below first_chars remove_repetition replace reverse swapcase)
    [
      `#{binpath}to_pass -C`,
      `#{binpath}to_pass --converters`
    ].each do |result|
      assert_match /available converters for password algorithms/, result
      converters.each do |converter|
        assert_match /#{converter}/, result
      end
    end
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
