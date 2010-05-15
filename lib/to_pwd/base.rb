module ToPwd
  class Base
    def initialize( string, algorithm )
      rules = YAML.load_file(Pathname.new("#{File.dirname(__FILE__)}/../algorithms/#{algorithm}.yml").expand_path)
      converter = Converter.new( rules )
      @password = converter.convert(string)
    end

    def to_s
      @password
    end
  end
end
