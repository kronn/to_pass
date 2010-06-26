# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

module ToPass
  # The StringConversions-Module is a collection of available
  # Transformations. Every method is given a string as single argument
  # and is expected to return a transformed string. The only exception
  # from this is general rule is the replace method which also takes a
  # replacement table.
  #
  # This enables chaining and eases extending the capabilities.
  module StringConversions
    autoload :CollapseChars, 'lib/to_pass/converters/collapse_chars.rb'
    autoload :FirstChars,    'lib/to_pass/converters/first_chars.rb'
    autoload :Replace,       'lib/to_pass/converters/replace.rb'
    autoload :Swapcase,      'lib/to_pass/converters/swapcase.rb'

    include CollapseChars
    include FirstChars
    include Replace
    include Swapcase
  end
end
