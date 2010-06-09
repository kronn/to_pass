module ToPwd
  class Base
    def initialize( string, algorithm )
      rules = AlgorithmReader.load(algorithm)
      converter = Converter.new( rules )
      @password = converter.convert(string)
    end

    def to_s
      @password
    end
  end
end
