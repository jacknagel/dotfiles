require "set"
require "keg"

ARGV.kegs.each do |keg|
  dylibs = Set.new

  keg.mach_o_files.each do |file|
    dylibs.merge file.dynamically_linked_libraries
  end

  dylibs.each do |dylib|
    begin
      owner = Keg.for(Pathname.new(dylib))
    rescue NotAKegError, Errno::ENOENT
      next
    end

    next if owner == keg

    puts "#{dylib} (#{owner.fname})"
  end
end
