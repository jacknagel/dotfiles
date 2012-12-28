class String
  def /(o); "#{self}/#{o}" end
end

task :default => :dotfiles

desc 'install dotfiles'
task :dotfiles => %w{dotfiles:link}

desc 'vim setup'
task :vim => %w{vim:tmp vim:command_t}

desc 'update submodules'
task :submodules => %w{submodules:update submodules:pull}

namespace :dotfiles do
  task :link do
    home = ENV['HOME']
    relative_prefix = pwd.sub(home/'', '')
    files = FileList[%w{bash* shrc git* vim vimrc irbrc pryrc rdebugrc gemrc ruby
      editrc inputrc history sqliterc psqlrc gdbinit valgrindrc}].existing!

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

  task :command_t do
    fail 'the active vim does not support Ruby' unless Vim.has_ruby?

    cd 'vim/bundle/command-t/ruby/command-t' do
      sh Vim.ruby_path, 'extconf.rb'
      sh 'make', 'clean'
      sh 'make'
    end
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

class Vim
  def self.has_ruby?
    vim(%{-e --noplugin --cmd 'if !has("ruby")|cquit|else|quit|endif'})
    $?.success?
  end

  def self.ruby_path
    scriptlet = %{
      require "rbconfig"
      config = RbConfig::CONFIG
      print config.fetch("bindir") + "/" + config.fetch("ruby_install_name")
    }
    vim("-e --noplugin --cmd 'ruby #{scriptlet}' --cmd q")
  end

  private

  def self.vim(*args)
    `vim #{args.join(" ")} 2>&1 >/dev/null`.strip
  end
end
