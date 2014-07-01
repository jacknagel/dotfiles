require "keg"
ARGV.kegs.each { |keg| keg.fix_install_names }
