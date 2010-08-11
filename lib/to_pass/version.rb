# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

# Library to convert a String into a Password
module ToPass # :nodoc:
  # version of gem, read directly from the VERSION-File
  VERSION = File.read(File.join(File.dirname(__FILE__), '../../VERSION')).strip

  # name of gem
  APP_NAME = 'to_pass'

  # date of last modification of the version
  DATE = File.mtime(File.join(File.dirname(__FILE__), '../../VERSION'))
end
