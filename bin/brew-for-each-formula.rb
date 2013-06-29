require 'formula'

def Homebrew.for_each_formula
  Formula.each { |f| eval(ARGV.first) }
end

Homebrew.for_each_formula
