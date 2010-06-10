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
    fn = load_path.map do |dir|
      file = Pathname.new("#{dir}/#{@algorithm}.yml")

      if file.exist?
        file
      else
        nil
      end
    end.compact.first

    YAML.load_file(fn.expand_path)
  end
end
