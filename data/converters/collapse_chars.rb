module ToPass::Converters
  class CollapseChars
    class << self
      # all the blanks are removed.
      #
      # this is useful if you convert a sentence into a password.
      def collapse_chars(string)
        string = string.split(' ').join('')
      end
    end
  end
end
