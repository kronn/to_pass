# vim:ft=ruby:fileencoding=utf-8

require File.expand_path('../helper', __FILE__)

class TestBase < Test::Unit::TestCase
  test_presence ToPass::Base

  def test_usage
    assert_nothing_raised do
      pwd = ToPass::Base.new("Da steht ein Pferd auf dem Flur", 'basic_de').to_s
      assert_equal "Ds1P@dF", pwd
    end
  end

  def test_options
    with_dir('/tmp/my_to_pass') do
      with_algorithm_in_user_dir('/tmp/my_to_pass/algorithms') do
        assert_equal 'te/t', ToPass::Base.new('test', :user_alg, :path => Pathname.new('/tmp/my_to_pass').expand_path).to_s
      end
    end
  end

  def test_version
    assert_match /\d+.\d+.\d+/, ToPass::VERSION
  end

  def test_date
    if in_to_pass_soure_tree?
      assert_equal Pathname.new("#{File.dirname(__FILE__)}/../lib/to_pass/version.rb").expand_path.mtime, ToPass::DATE
    else
      assert_not_nil ToPass::DATE
    end
  end

  def test_appname
    assert_equal "to_pass", ToPass::APP_NAME
  end

  def test_gemspec_is_valid
    if in_to_pass_soure_tree?
      assert_nothing_raised do
        assert eval(File.read(File.expand_path('../../to_pass.gemspec', __FILE__))).validate
      end
    end
  end

  def test_release_notes
    fn = File.expand_path('../../doc/RELEASE_NOTES', __FILE__)

    if File.size?(fn)
      assert_equal File.read(fn), ToPass::RELEASE_NOTES
    else
      assert_nil ToPass::RELEASE_NOTES
    end
  end
end
