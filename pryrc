# vim:set ft=ruby:
#
require 'pry-editline'

$LOAD_PATH.unshift(File.expand_path("."))
$LOAD_PATH.uniq!

Pry.config.history.file = if defined?(HOMEBREW_REPOSITORY)
                            HOMEBREW_REPOSITORY/"Meta/irb_history"
                          else
                            File.expand_path("~/.history/irb")
                          end
