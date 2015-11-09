task :default => :dotfiles

desc "Install dotfiles"
task :dotfiles => %w{dotfiles:link}

desc "Bootstrap vim setup"
task :vim => %w{vim:tmp vim:helptags}

desc "Update submodules"
task :submodules => %w{submodules:update submodules:pull}

namespace :dotfiles do
  task :link do
    home = ENV["HOME"]
    relative_prefix = pwd.sub("#{home}/", "")
    files = FileList[%w{
      bash* bundle ctags editrc gdbinit gemrc git* history inputrc irbrc
      less lesskey psqlrc ruby shrc sqliterc valgrindrc vim vimrc
    }].existing!

    files.zip(files.pathmap(File.join(home, ".%p"))) do |src, dst|
      if File.symlink? dst and File.dirname(File.readlink(dst)) == relative_prefix
        next
      elsif File.exist? dst
        STDERR.puts "#{dst} exists, skipping"
      else
        ln_s File.join(relative_prefix, src), dst
      end
    end

    unless File.directory? File.join(home, "bin")
      ln_s File.join(relative_prefix, "bin"), File.join(home, "bin")
    end
  end
end

namespace :vim do
  task :tmp do
    mkdir_p %w{vim/_backup vim/_swap vim/_undo}
  end

  task :helptags do
    sh "vim", "-e", "-c", "Helptags", "-c", "q"
  end
end

namespace :submodules do
  task :update do
    sh "git", "submodule", "sync", "-q"
    sh "git", "submodule", "update", "--init", "--recursive", "-q"
  end

  task :pull => :update do
  sh "git", "submodule", "foreach", "--recursive", "-q",
    %{git pull -q --ff-only && git --no-pager lg "master@{#{Time.now}}.." || :}
  end
end

namespace :gems do
  gems = %w{
    allocation_tracer
    benchmark-ips
    bundler
    gc_tracer
    gem-ripper-tags
    minitest
    octokit
    ripper-tags
    stackprof
  }

  desc "Install base gems for the current Ruby"
  task :bootstrap do
    sh "gem", "update", "--system"
    sh "gem", "install", *gems
    sh "gem", "ripper_tags", "--reindex"
  end
end
