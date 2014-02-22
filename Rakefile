class String
  def /(o); "#{self}/#{o}" end
end

task :default => :dotfiles

desc 'Install dotfiles'
task :dotfiles => %w{dotfiles:link}

desc 'Bootstrap vim setup'
task :vim => %w{vim:tmp vim:helptags}

desc 'Update submodules'
task :submodules => %w{submodules:update submodules:pull}

namespace :dotfiles do
  task :link do
    home = ENV['HOME']
    relative_prefix = pwd.sub(home/'', '')
    files = FileList[%w{
      bash* shrc git* vim vimrc editrc inputrc
      irbrc pryrc rdebugrc gemrc ruby bundle
      lesskey less ctags
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

  task :helptags do
    sh 'vim', '-e', '-c', 'Helptags', '-c', 'q'
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

namespace :gems do
  gems = %w{
      benchmark-ips
      bundler
      ffi
      gem-browse
      pry
      pry-editline
      ripper-tags
      gem-ripper-tags
  }

  desc 'Install base gems for the current Ruby'
  task :bootstrap do
    sh 'gem', 'update', '--system'
    sh 'gem', 'install', *gems
    sh 'gem', 'ripper_tags', '--reindex'
  end
end
