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

  DIRECTORIES = Class.new do
    class << self
      def [](key)
        case key
        when :user, :data, :base, :source_data
          all[key]
        when :standard
          [ all[:user], all[:data], all[:source_data] ]
        end
      end

      private

      def all
        {
          :user => "~/.#{APP_NAME}",
          :data => "#{RbConfig::CONFIG['data-dir']}/#{APP_NAME}",
          :base => File.expand_path("#{File.dirname(__FILE__)}/.."),
          :source_data => File.expand_path("#{File.dirname(__FILE__)}/../data/#{APP_NAME}"),
        }
      end
    end
  end
end
