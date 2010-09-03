# vim:ft=ruby:fileencoding=utf-8

module ToPass
  # version of gem
  VERSION = '0.6.0' unless defined?(ToPass::VERSION)

  # name of gem
  APP_NAME = 'to_pass' unless defined?(ToPass::APP_NAME)

  # date of last modification of the version
  DATE = File.mtime(__FILE__) unless defined?(ToPass::DATE)

  # Purpose in one sentence
  SUMMARY = 'generate password from words or sentences' unless defined?(ToPass::SUMMARY)

  # short description, see README for details
  DESCRIPTION = <<-EOD unless defined?(ToPass::DESCRIPTION)
    Passwords should be easy to remember and hard to guess.
    One technique is to have a sentence which can be easily remembered transformed to a password.

    Pluggable algorithms and converters allow customization of the transformation process.
  EOD
end
