#!/usr/bin/env thor
# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

class ToPass < Thor
  desc "algorithms", "list available algorithms"
  def algorithms
    require 'lib/to_pass'

    puts("")
    puts("  available password algorithms")
    puts("  ============================================")
    ::ToPass::AlgorithmReader.discover.each do |algorithm|
      puts("  - #{algorithm}")
    end
    puts("  ============================================")
    puts("")
  end

  desc "converters", "list available converters"
  def converters
    require 'lib/to_pass'

    puts("")
    puts("  available converters for password algorithms")
    puts("  ============================================")
    ::ToPass::ConverterReader.new.discover.each do |converter|
      puts("  - #{converter}")
    end
    puts("  ============================================")
    puts("")
  end
end

class ToPassDevelopment < Thor
  desc "man", "generate manpages for project"
  def man
    files = Dir["./man/*.ronn"].join(" ")
    command = "ronn --html --roff --style=toc #{files}"
    `#{command}`
  end

  desc "clobber_rdoc", "Remove rdoc products"
  def clobber_rdoc
  proc { rm_r(rdoc_dir) rescue nil }
  end

  desc "rdoc", "Build the rdoc HTML Files"
  def rdoc
    compile_doc_slash_rdoc_slash_index_dot_html
  end

  desc "rerdoc", "Force a rebuild of the RDOC files"
  def rerdoc
    clobber_rdoc
    rdoc
  end

  desc "test", "run tests"
  def test
    ["redgreen"].each do |lib|
      begin
        require(lib)
      rescue LoadError
        # do nothing
      end
    end
    (["test/unit", "test/helper"] + Dir["test/test_*.rb"]).each do |file|
      require(file)
    end
  end

  private

  def compile_doc
    proc { |t| mkdir_p(t.name) unless File.exist?(t.name) }
  end

  def compile_doc_slash_rdoc
    proc { |t| mkdir_p(t.name) unless File.exist?(t.name) }
  end

  def compile_doc_slash_rdoc_slash_index_dot_html
    rm_r(@rdoc_dir) rescue nil
    @before_running_rdoc.call if @before_running_rdoc
    args = (option_list + @rdoc_files)
    if @external then
      argstring = args.join(" ")
      sh("ruby -Ivendor vendor/rd #{argstring}")
    else
      require("rdoc/rdoc")
      RDoc::RDoc.new.document(args)
    end
  end
end
