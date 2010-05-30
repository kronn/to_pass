require 'pathname'
require 'yaml'

module ToPwd
  autoload :Converter,         'lib/to_pwd/converter'
  autoload :StringConversions, 'lib/to_pwd/string_conversions'
  autoload :Base,              'lib/to_pwd/base'
end

# module PasswordTransformation
# 	def to_pwd( algorithm = 'basic_de' )
# 		ToPwd::Base.new(self.to_s, algorithm).to_s
# 	end
# end
# 
# String.send(:include, PasswordTransformation)
# 
# puts "Da steht ein Pferd auf dem Flur".to_pwd => 'Ds1P@dF'
