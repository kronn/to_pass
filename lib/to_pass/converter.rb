# vim:ft=ruby:fileencoding=utf-8

module ToPass # :nodoc:
  # converts a given string into a password-like word
  #
  # the string can be a word or a sentence. everthing which
  # contains whitespace is considered a sentence
  #
  # a more complete description of the algorithm capabilities
  # is still pending.
  #
  # see ToPass::ConverterReader and ToPass::AlgorithmReader
  class Converter
    attr_accessor :converters, :rules
    # create a new converter, based on a set of conversion-rules
    def initialize( rules )
      @rules = rules
      @reader = ConverterReader.new
      @converters = @reader.discover
    end

    # convert a string into a password
    def convert( string )
      process(string, rules_for(string))
    end

    # class << self
    #   # convenience method to apply conversion rules to a string
    #   def apply(rules, string)
    #     new(rules).convert(string)
    #   end
    #   # convenience method to convert a string based on rules
    #   def convert(string, rules)
    #     new(rules).convert(string)
    #   end
    # end

    # proxy to converters
    def respond_to?(method_name) # :nodoc:
      if [:convert, :rules_for, :process].include? method_name.to_sym
        true
      elsif @converters.include? method_name.to_sym
        true
      else
        super
      end
    end

    private

    # return the applicable rules for a given string.
    #
    # everything which contains whitespace is considered a sentence,
    # otherwise it is most likely a word.
    def rules_for( string )
      if string.include? ' ' or /\s/.match(string)
        @rules['sentence']
      else
        @rules['word']
      end
    end

    # process the string, rule by rule
    def process(string, rules)
      rules.inject(string) do |pwd, rule|
        apply_rule(pwd, rule)
      end
    end

    # apply a single rule to the password-to-be
    def apply_rule(pwd, rule)
      cmd, args = rule.to_a.flatten
      m = @reader.load(cmd.to_sym).method(cmd.to_sym)

      case m.arity
      when 1
        m.call(pwd)
      when 3, -2
        m.call(pwd, @rules, *args)
      end
    end
  end
end
