# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require 'pathname'
require 'yaml'

# The AlgorithmReader's primary API is the load the rules from a YAML-file
# into a Hash.
#
# Algorithms are searched in the following locations
#
# 1. ~/.to_pass/algorithms
# 2. bundled algorithms of gem
#
class ToPass::AlgorithmReader
  attr_reader :load_path

  def initialize(algorithm) # :nodoc:
    @algorithm = algorithm
    @load_path = []
    [
      '~/.to_pass/algorithms',
      "#{File.dirname(__FILE__)}/../algorithms"
    ].each do |dir|
      dir = Pathname.new(dir).expand_path
      @load_path << dir if dir.exist?
    end
  end

  class << self
    # load an algorithm with a given identifier
    def load(algorithm)
      new(algorithm).load_from_file
    end
  end

  def load_from_file # :nodoc:
    fn = load_path.map do |dir|
      file = Pathname.new("#{dir}/#{@algorithm}.yml")

      if file.exist?
        file
      else
        next
      end
    end.compact.first

    raise LoadError, "algorithm #{@algorithm} could not be found in #{load_path}" if fn.nil?

    YAML.load_file(fn.expand_path)
  end
end
