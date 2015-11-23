IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:USE_READLINE] = true
IRB.conf[:LOAD_MODULES] |= %w{irb/completion}
IRB.conf[:HISTORY_FILE] =
  if defined?(Bundler)
    Bundler.tmp.parent.join("history")
  else
    File.expand_path("~/.history/irb")
  end
