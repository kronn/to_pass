# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require 'rbconfig'

# Library to convert a String into a Password
module ToPass
  autoload :VERSION,           'lib/to_pass/version'
  autoload :DATE,              'lib/to_pass/version'
  autoload :APP_NAME,          'lib/to_pass/version'

  autoload :AlgorithmReader,   'lib/to_pass/algorithm_reader'
  autoload :Base,              'lib/to_pass/base'
  autoload :Cli,               'lib/to_pass/cli.rb'
  autoload :Converter,         'lib/to_pass/converter'
  autoload :ConverterReader,   'lib/to_pass/converter_reader'
  autoload :Converters,        'lib/to_pass/converters'
  autoload :Integration,       'lib/to_pass/integration'
end
