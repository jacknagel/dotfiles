$LOAD_PATH.reject! { |dir| not File.directory?(dir) }
$LOAD_PATH.uniq!

%w{
  date
  fileutils
  pathname
  pp
  set
  stringio
  tmpdir
}.each do |lib|
  begin
    require(lib)
  rescue LoadError
  end
end
