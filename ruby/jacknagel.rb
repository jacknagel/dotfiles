$LOAD_PATH.reject! { |dir| not File.directory?(dir) }
$LOAD_PATH.uniq!

%w{date fileutils pathname pp set stringio tmpdir}.each do |lib|
  begin
    require lib
  rescue LoadError
  end
end

def time(count=1, &block)
  require "benchmark"
  Benchmark.bmbm do |x|
    x.report do
      count.times(&block)
    end
  end.first
end
