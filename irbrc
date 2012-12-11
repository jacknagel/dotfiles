$LOAD_PATH.unshift(File.expand_path("~/.ruby"))
$LOAD_PATH.unshift(File.expand_path("."))
$LOAD_PATH.uniq!

%w{rubygems pry pry-editline jacknagel}.each do |lib|
  begin
    require lib
  rescue LoadError
  end
end

if defined?(Pry)
  Pry.start
  exit
end

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
