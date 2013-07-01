class String
  def /(o); "#{self}/#{o}" end
end

task :default => :dotfiles

desc 'Install dotfiles'
task :dotfiles => %w{dotfiles:link}

desc 'Bootstrap vim setup'
task :vim => %w{vim:tmp}

desc 'Update submodules'
task :submodules => %w{submodules:update submodules:pull}

namespace :dotfiles do
  task :link do
    home = ENV['HOME']
    relative_prefix = pwd.sub(home/'', '')
    files = FileList[%w{
      bash* shrc git* vim vimrc editrc inputrc
      irbrc pryrc rdebugrc gemrc ruby ruby-version
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

namespace :ruby do
  namespace :install do
    desc 'Install Ruby'
    task :ruby, :version, :url do |_, args|
      cmd = %w{ruby-install ruby}
      cmd << args.version if args.version
      cmd << '--url' << args.url if args.url
      cmd.concat %w{-- --disable-silent-rules --disable-install-doc --with-out-ext=tk --enable-dtrace CFLAGS=-O3}
      sh(*cmd)
    end

    desc 'Install JRuby'
    task :jruby, :version, :url do |_, args|
      cmd = %w{ruby-install jruby}
      cmd << args.version if args.version
      cmd << '--url' << args.url if args.url
      sh(*cmd)
    end
  end

  namespace :gems do
    DEFAULT_GEMS = %w{bundler ffi gem-browse gem-ctags pry}

    desc 'Install base gems for the current Ruby'
    task :bootstrap do
      sh 'gem', 'install', *DEFAULT_GEMS
      sh 'gem', 'ctags'
    end
  end
end
