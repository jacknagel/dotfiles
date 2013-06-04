class String
  def /(o); "#{self}/#{o}" end
end

task :default => :dotfiles

desc 'install dotfiles'
task :dotfiles => %w{dotfiles:link}

desc 'vim setup'
task :vim => %w{vim:tmp}

desc 'update submodules'
task :submodules => %w{submodules:update submodules:pull}

namespace :dotfiles do
  task :link do
    home = ENV['HOME']
    relative_prefix = pwd.sub(home/'', '')
    files = FileList[%w{
      bash* shrc git* vim vimrc editrc inputrc
      irbrc pryrc rdebugrc gemrc ruby
      lesskey less
      history sqliterc psqlrc gdbinit valgrindrc
    }].existing!

    files.zip(files.pathmap(home/".%p")) do |src, dst|
      if File.symlink? dst and File.dirname(File.readlink(dst)) == relative_prefix
        next
      elsif File.exist? dst
        STDERR.puts "#{dst} exists, skipping"
      else
        ln_s relative_prefix/src, dst
      end
    end

    unless File.directory? home/:bin
      ln_s relative_prefix/:bin, home/:bin
    end
  end
end

namespace :vim do
  task :tmp do
    mkdir_p %w{vim/_backup vim/_swap vim/_undo}
  end
end

namespace :submodules do
  task :update do
    sh 'git', 'submodule', 'sync', '-q'
    sh 'git', 'submodule', 'update', '--init', '-q'
  end

  task :pull => :update do
  sh 'git', 'submodule', 'foreach', '-q',
    %{git pull -q --ff-only && git --no-pager lg "master@{#{Time.now}}.." || :}
  end
end
