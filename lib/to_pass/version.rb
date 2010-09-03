# vim:ft=ruby:fileencoding=utf-8

module ToPass
  # version of gem
  VERSION = '0.6.0'

  # name of gem
  APP_NAME = 'to_pass'

  # date of last modification of the version
  DATE = File.mtime(__FILE__)

  # Purpose in one sentence
  SUMMARY = 'generate password from words or sentences'

  # short description, see README for details
  DESCRIPTION = <<-EOD
    Passwords should be easy to remember and hard to guess.
    One technique is to have a sentence which can be easily remembered transformed to a password.

    Pluggable algorithms and converters allow customization of the transformation process.
  EOD
end
