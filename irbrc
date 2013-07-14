$LOAD_PATH.unshift(File.expand_path("~/.ruby"))
$LOAD_PATH.uniq!

%w{
  rubygems
  pry
  jacknagel
}.each do |lib|
  begin
    require(lib)
  rescue LoadError
  end
end

(Pry.start; exit) if defined?(Pry)

IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:USE_READLINE] = true
IRB.conf[:LOAD_MODULES] |= %w{irb/completion}
IRB.conf[:HISTORY_FILE] =
  if defined?(Homebrew)
    HOMEBREW_REPOSITORY.join("Meta/irb_history")
  elsif defined?(Bundler)
    Bundler.tmp.parent.join("history")
  else
    File.expand_path("~/.history/irb")
  end
