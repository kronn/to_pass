require 'test/unit/testcase'
require 'test/unit' unless defined?(Test::Unit)
require 'mocha'

base_path = ( File.expand_path(File.dirname(__FILE__)+'/..') )
$LOAD_PATH << base_path unless $LOAD_PATH.include?(base_path)

require 'lib/to_pwd'
