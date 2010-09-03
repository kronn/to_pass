# vim:ft=ruby:fileencoding=utf-8

# Any Object can be a password, as long as it has a string representation.
#
# This Module provides a shortcut to the password-conversion.
#
#   String.send(:include, ToPass::Integration)
#   puts "Da steht ein Pferd auf dem Flur".to_pass => 'Ds1P@dF'
#
# See ToPass::Base for more details
module ToPass::Integration
  # simplified password-creation
  def to_pass( algorithm = 'basic_de' )
    ToPass::Base.new(self.to_s, algorithm).to_s
  end
end
