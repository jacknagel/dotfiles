IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:USE_READLINE] = true
IRB.conf[:LOAD_MODULES] |= %w{irb/completion}
IRB.conf[:HISTORY_FILE] = File.expand_path("~/.history/irb")
