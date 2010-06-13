module ToPwd
  # converts a given string into a password-like word
  #
  # the string can be a word or a sentence. everthing which
  # contains whitespace is considered a sentence
  #
  # a more complete description of the algorithm capabilities
  # is still pending.
  class Converter
    # create a new converter, based on a set of conversion-rules
    def initialize( rules )
      @rules = rules
    end

    # convert a string into a password
    def convert( string )
      process(string, rules_for(string))
    end

    protected

    include StringConversions

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
        if rule.is_a?(String) and respond_to?(rule.to_sym)
          send(rule.to_sym, pwd)
        elsif rule.is_a?(Hash) and rule.has_key?('table')
          replace(pwd, @rules['tables'][rule.fetch('table')])
        else
          pwd
        end
      end
    end
  end
end
