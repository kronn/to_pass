require 'test/unit/testcase'
require 'test/unit' unless defined?(Test::Unit)
require 'mocha'

base_path = ( File.expand_path(File.dirname(__FILE__)+'/..') )
$LOAD_PATH << base_path unless $LOAD_PATH.include?(base_path)

Test::Unit::TestCase.class_eval do
  def assert_class_defined(klass)
    assert defined?(klass), "#{klass} should be defined"
    assert_kind_of Class, klass, "#{klass} should be a class"
  end

  def assert_module_defined(modul)
    assert defined?(modul), "#{modul} should be defined"
    assert_kind_of Module, modul, "#{modul} should be a module"
  end

  def self.test_presence(klass)
    define_method "test_presence" do
      assert_class_defined klass
    end
  end
end

require 'lib/to_pass'
