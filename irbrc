IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.history/irb')

require 'rubygems'
require 'irb/completion'
require 'fileutils'
require 'pathname'
require 'tmpdir'
require 'date'
require 'set'
require 'pp'

module Kernel extend self
  alias_method :r, :require
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
