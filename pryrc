# vim:set ft=ruby:

require "rubygems" unless defined?(Gem)

begin
  require "pry-editline"
rescue LoadError
end

Pry.config.history.file =
  if defined?(Homebrew)
    HOMEBREW_REPOSITORY.join("Meta/irb_history")
  elsif defined?(Bundler)
    Bundler.tmp.parent.join("history")
  else
    File.expand_path("~/.history/irb")
  end

Pry.config.prompt_name =
  if defined?(Homebrew)
    "brew"
  elsif defined?(Rails)
    Rails.application.class.parent_name
  elsif defined?(Bundler)
    Bundler.root
  else
    "pry"
  end.to_s.downcase.slice(0..7)

ruby_version = lambda {
  RUBY_VERSION >= "2.1" ? RUBY_VERSION : "#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}"
}

Pry.config.prompt = [
  lambda { |obj, nest, pry|
    "[#{pry.input_array.size}] #{ruby_version.call} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})#{":#{nest}" unless nest.zero?}> "
  },
  lambda { |obj, nest, pry|
    "[#{pry.input_array.size}] #{ruby_version.call} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})#{":#{nest}" unless nest.zero?}* "
  }
]
