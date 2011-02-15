# vim:ft=ruby:fileencoding=utf-8

unless defined?(ToPass::VERSION)
  module ToPass
    # version of gem
    VERSION = '1.0.0'

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

    # list of file which should be included in rdoc
    EXTRA_RDOC_FILES = ['doc/CHANGELOG', 'doc/LICENSE', 'README.rdoc', 'TODO']

    # easy access to the RELEASE_NOTES
    RELEASE_NOTES = begin
      fn = File.expand_path('../../../doc/RELEASE_NOTES', __FILE__)
      File.read(fn) if File.size?(fn)
    end
  end
end
