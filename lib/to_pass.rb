# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

# Library to convert a String into a Password
module ToPass
  # version of gem, read directly from the VERSION-File
  VERSION = File.read(File.join(File.dirname(__FILE__), '../VERSION')).strip

  # name of gem
  APP_NAME = 'to_pass'

  autoload :AlgorithmReader,   'lib/to_pass/algorithm_reader'
  autoload :Base,              'lib/to_pass/base'
  autoload :Cli,               'lib/to_pass/cli.rb'
  autoload :Converter,         'lib/to_pass/converter'
  autoload :Integration,       'lib/to_pass/integration'
  autoload :StringConversions, 'lib/to_pass/string_conversions'
end
