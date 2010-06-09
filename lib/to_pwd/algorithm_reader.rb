require 'pathname'
require 'yaml'

class ToPwd::AlgorithmReader
  def initialize(algorithm)
    @algorithm = algorithm
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
