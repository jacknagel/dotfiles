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
