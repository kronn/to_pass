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
# The bundled converter are, however, lazily loaded with autoload.
# User-provided converters are always required (for now).
#
class ToPass::ConverterReader
  attr_reader :load_path, :loaded

  def initialize # :nodoc:
    @load_path  = []
    @loaded     = []
    @discovered = []
    [
      '~/.to_pass/converters',
      "#{File.dirname(__FILE__)}/converters"
    ].each do |dir|
      dir = Pathname.new(dir).expand_path
      @load_path << dir if dir.exist?
    end
  end

  # loads the converters
  def load(converter)
    unless @loaded.include?(converter.to_sym)
      load_from_file(converter)
      @loaded << converter
    end

    classname(converter)
  end

  # discover a list of available converters
  def discover
    search_for_converters
  end

  private

  def search_for_converters # :nodoc:
    files = load_path.collect do |directory|
      dir = Pathname.new(directory)
      if dir.exist?
        Dir["#{dir}/*.rb"].collect do |converter|
          fn_re = %r!/([^/]*)\.rb$!i
          name  = converter.match(fn_re)
          if name
            name[1].to_sym
          end
        end
      end
    end.flatten.compact

    raise LoadError, "converters could not be found in #{load_path}" if files.nil?

    @discovered = files
  end

  def load_from_file(converter) # :nodoc:
    fn = load_path.collect do |dir|
      path = Pathname.new("#{dir}/#{converter}.rb").expand_path

      if path.exist?
        path
      else
        next
      end
    end.compact.first

    raise LoadError, "converter '#{converter}' could not be found in #{load_path}" if fn.nil?

    if require fn
      classname converter
    end
  end

  def classname(converter) # :nodoc:
    constantize("ToPass::Converters::#{camel_case(converter)}")
  end

  def constantize(camel_cased_word) # :nodoc:
    names = camel_cased_word.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end
    constant
  end

  def camel_case(underscored_word) # :nodoc:
    camel_cased_word = underscored_word.to_s.split('_').map do |part|
      part.capitalize
    end.join('')
  end
end
