# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require 'pathname'

# The ConverterReader's primary API is to load the converters from right
# directories into an Array
#
# Converters are searched in the following locations
#
# 1. ~/.to_pass/converters
# 2. bundled converters of gem
#
class ToPass::ConverterReader
  attr_reader :load_path, :loaded

  def initialize # :nodoc:
    @load_path = []
    @loaded    = []
    [
      '~/.to_pass/converters',
      "#{File.dirname(__FILE__)}/converters"
    ].each do |dir|
      dir = Pathname.new(dir).expand_path
      @load_path << dir if dir.exist?
    end
  end

  class << self
    # loads the converters
    def load
      new.load_from_file
    end
  end

  def load_from_file # :nodoc:
    files = load_path.collect do |directory|
      dir = Pathname.new(directory)
      if dir.exist?
        Dir["#{dir}/*.rb"].collect do |converter|
          fn_re = %r!/([^/]*)\.rb$!i
          name  = converter.match(fn_re)

          if name
            require converter
            name[1].to_sym
          else
            raise LoadError "converter #{converter} could not be loaded"
          end
        end
      end
    end.flatten.compact

    raise LoadError, "converters could not be found in #{load_path}" if files.nil?

    @loaded = files
  end
end
