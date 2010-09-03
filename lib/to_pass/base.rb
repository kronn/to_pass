# vim:ft=ruby:fileencoding=utf-8

module ToPass
  # ToPass::Base is mostly a facade for the library.
  #
  # Given a string and a algorithm identifier, the right rules
  # are loaded and applied to the string. With a simple "to_s",
  # you can get the final password.
  #
  # see ToPass::AlgorithmReader and ToPass::Converter for details
  class Base
    # transform a string according to a certain algorithm
    def initialize( string, algorithm )
      rules = AlgorithmReader.load(algorithm)
      converter = Converter.new( rules )
      @password = converter.convert(string)
    end

    # return the generated password
    def to_s
      @password
    end
  end
end
