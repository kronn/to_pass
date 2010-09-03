# vim:ft=ruby:fileencoding=utf-8

module ToPass::Converters
  # replace the string "USER" with the current username
  class Userize
    def self.convert(string) # :nodoc:
      username = if `which whoami`
                   `whoami`.chomp
                 else
                   "thecurrentuser"
                 end

      string.gsub("USER",username)
    end
  end
end
