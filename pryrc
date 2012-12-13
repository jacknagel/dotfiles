# vim:set ft=ruby:

$LOAD_PATH.unshift(File.expand_path("~/.ruby"))
$LOAD_PATH.unshift(File.expand_path("."))
$LOAD_PATH.uniq!

%w{rubygems pry-editline jacknagel}.each do |lib|
  begin
    require "lib"
  rescue LoadError
  end
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

Pry.config.prompt = [
  proc do |obj, nest, pry|
    "[#{pry.input_array.size}] #{RUBY_VERSION} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})#{":#{nest}" unless nest.zero?}> "
  end,
  proc do |obj, nest, pry|
    "[#{pry.input_array.size}] #{RUBY_VERSION} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})#{":#{nest}" unless nest.zero?}* "
  end
]

extend Rails::ConsoleMethods if defined?(Rails)
