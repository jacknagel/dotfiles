require 'rubygems'
require 'irb/completion'
require 'fileutils'
require 'pathname'
require 'tmpdir'
require 'date'
require 'set'
require 'pp'

$LOAD_PATH.unshift(File.expand_path("."))
$LOAD_PATH.uniq!

module Kernel extend self
  alias_method :r, :require
end

IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = if defined?(HOMEBREW_REPOSITORY)
                            HOMEBREW_REPOSITORY/"Meta/irb_history"
                          else
                            File.expand_path('~/.history/irb')
                          end

def time(times = 1)
  require 'benchmark'
  ret = nil
  Benchmark.bm do |x|
    x.report do
      times.times do
        ret = yield
      end
    end
  end
  ret
end
