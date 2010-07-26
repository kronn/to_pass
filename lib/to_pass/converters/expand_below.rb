require 'md5'

module ToPass::Converters
  class ExpandBelow
    class << self
      def expand_below(string, rules, threshold)
        if string.length < threshold.to_i
          digest = "#{MD5.hexdigest(string)}#{MD5.hexdigest(string).reverse}"
          extension = 1.upto(digest.length / 2).map do |nr|
            char = digest[(nr*2-2),2].to_i(16).chr
            char if char =~ /\w/i
          end.compact.join

          string + extension
        else
          string
        end
      end
    end
  end
end
