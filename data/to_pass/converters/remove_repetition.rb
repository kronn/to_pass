module ToPass::Converters
  class RemoveRepetition
    class << self
      # remove duplicate characters by replacing them with the character and the count
      def remove_repetition(string)
        string.split('').inject('') do |memo, char|
          if memo.size <= 1
            memo << char
          else
            last = memo[memo.size-1].chr
            if last == char
              memo << '2'
            elsif last =~ /\d/ and memo[memo.size-2].chr == char
              memo.succ
            else
              memo << char
            end
          end
        end
      end
    end
  end
end
