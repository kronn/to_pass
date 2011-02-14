source :rubygems
gemspec

group :optional do
  group :test do
    gem 'redgreen' if Gem.available?('redgreen')
    gem 'test_benchmark'
  end

  group :development do
    gem 'gem-release'
    gem 'vclog'
  end
end
