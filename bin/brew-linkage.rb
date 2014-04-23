require "set"
require "keg"

ARGV.kegs.each do |keg|
  dylibs = Set.new

  keg.find do |file|
    if file.dylib? || file.mach_o_executable? || file.mach_o_bundle?
      dylibs.merge file.dynamically_linked_libraries
    end
  end

  dylibs.each do |dylib|
    begin
      owner = Keg.for(Pathname.new(dylib))
    rescue NotAKegError, Errno::ENOENT
    end

    print dylib
    print " (#{owner.fname})" if owner
    puts
  end
end
