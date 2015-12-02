require "pathname"

task :default => :dotfiles

desc "Install dotfiles"
task :dotfiles => %w{dotfiles:link}

desc "Bootstrap vim setup"
task :vim => %w{vim:tmp vim:helptags}

desc "Update submodules"
task :submodules => %w{submodules:update submodules:pull}

def relative_path(to, from)
  Pathname.new(to).expand_path.relative_path_from(Pathname.new(from))
end

namespace :dotfiles do
  dotfiles = FileList[%w{
    bash*
    bundle/config
    config/git
    ctags
    editrc
    gemrc
    histignore
    inputrc
    irbrc
    less
    lesskey
    psqlrc
    shrc
    sqliterc
    valgrindrc
    vim
    vimrc
  }].existing!

  dotfiles.each do |dotfile|
    dst = File.expand_path(".#{dotfile}", "~")
    dirname = File.dirname(dst)

    task dotfile => dst
    directory dirname
    file dst => dirname do
      ln_s relative_path(dotfile, dirname), dst
    end
  end
  task :link => dotfiles

  bin = File.expand_path("~/bin")
  file bin do |t|
    dirname = File.dirname(t.name)
    ln_s relative_path("bin", dirname), t.name
  end
  task :link => bin
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
    %{git pull -q --no-rebase --ff-only && git --no-pager lg "master@{#{Time.now}}.." || :}
  end
end
