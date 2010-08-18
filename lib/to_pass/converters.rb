# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

module ToPass
  # The Converters-module is a collection of available
  # Transformations.
  #
  # Each Transformation is wrapped in a class which has one class-method. This
  # method is given a string as single argument.
  # If the method can take arguments, then three parameters are passed:
  # the string, the full rule-set (algorithm definition hash) and the parameter
  # from the algorithm.
  # see ToPass::Converter#apply_rule for details
  #
  # All transformations are expected to return only the transformed string.
  # This enables chaining and eases extending the capabilities.
  module Converters
  end
end
