IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.history/irb')

IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => "[%N(%m)]$ ",
  :PROMPT_S => " [%l]> ",
  :PROMPT_C => " stmt> ",
  :PROMPT_N => "[%03i(%m)]> ",
  :RETURN   => " ====> %s\n"
}

IRB.conf[:PROMPT_MODE] = :CUSTOM

require 'irb/completion'
require 'pathname'
require 'pp'
require 'rubygems'

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
