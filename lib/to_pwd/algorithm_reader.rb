require 'pathname'
require 'yaml'

class ToPwd::AlgorithmReader
  attr_reader :load_path

  def initialize(algorithm)
    @algorithm = algorithm
    @load_path = []
    [
      '~/.to_pass/algorithms',
      "#{File.dirname(__FILE__)}/../algorithms"
    ].each do |dir|
      dir = Pathname.new(dir)
      @load_path << dir.expand_path if dir.exist?
    end
  end

  class << self
    def load(algorithm)
      new(algorithm).load_from_file
    end
  end

  def load_from_file
    YAML.load_file(algorithm_file_name.expand_path)
  end

  private

  def algorithm_file_name
    Pathname.new("#{File.dirname(__FILE__)}/../algorithms/#{@algorithm}.yml")
  end
end
