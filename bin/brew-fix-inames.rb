require 'keg'

def Homebrew.fix_install_names
  ARGV.formulae.each { |f| Keg.new(f.opt_prefix).fix_install_names }
end

Homebrew.fix_install_names
