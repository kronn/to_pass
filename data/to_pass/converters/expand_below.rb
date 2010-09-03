require 'digest/md5'

module ToPass::Converters
  class ExpandBelow
    class << self
      # Strings below the threshold are expanded with a md5-hash of them.
      #
      # The md5 is used to generate extra characters which are then added
      # before and after the string.
      def expand_below(string, rules, threshold)
        if string.length < threshold.to_i
          digest = "#{Digest::MD5.hexdigest(string)}#{Digest::MD5.hexdigest(string).reverse}"
          extension = 1.upto(digest.length / 2).map do |nr|
            char = digest[(nr*2-2),2].to_i(16).chr
            char if char =~ /\w/i
          end.compact.join

          part1 = extension[0,(extension.length/2).floor]
          part2 = extension.gsub(part1,'')

          part1 + string + part2
        else
          string
        end
      end
    end
  end
end
