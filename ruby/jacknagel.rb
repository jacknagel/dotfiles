$LOAD_PATH.reject! { |dir| not File.directory?(dir) }
$LOAD_PATH.uniq!

%w{
  date
  fileutils
  open-uri
  ostruct
  pathname
  set
  stringio
  tmpdir
}.each do |lib|
  begin
    require(lib)
  rescue LoadError
  end
end
