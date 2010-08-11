module ToPass::Converters
  class FirstChars
    class << self
      # reduces every word to its first character, preserving case
      def first_chars(string)
        string.split(' ').map do |word|
          word[0].chr
        end.join(' ')
      end
    end
  end
end
