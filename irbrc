require 'rubygems'
require 'irb/completion'
require 'fileutils'
require 'pathname'
require 'tmpdir'
require 'date'
require 'set'
require 'pp'

$LOAD_PATH << File.expand_path('.')
$LOAD_PATH.uniq!

module Kernel extend self
  alias_method :r, :require
end

IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = if defined?(HOMEBREW_REPOSITORY)
                            HOMEBREW_REPOSITORY/'Meta/irb_history'
                          else
                            File.expand_path('~/.history/irb')
                          end

def time(count=1, &block)
  require 'benchmark'
  Benchmark.bmbm do |x|
    x.report { count.times(&block) }
  end.first
end
