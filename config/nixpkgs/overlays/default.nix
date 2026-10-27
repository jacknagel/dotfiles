self: super:

{
  userPackages = super.userPackages or {} // {
    inherit (self)
      avrdude
      aws-vault
      awscli2
      bash-completion
      bashInteractive
      certigo
      complete-alias
      curlFull
      direnv
      dive
      editorconfig-core-c
      fd
      ffmpeg
      findutils
      fzy
      gettext
      gh
      gist
      git-absorb
      git-lfs
      github-copilot-cli
      gitFull
      glab
      gnugrep
      go_1_27
      gomplate
      graphviz
      jq
      kubectl
      kubectx
      kubernetes-helm
      kustomize
      less
      mkvtoolnix
      mysql-client
      nodejs_24
      packer
      par2cmdline
      ripgrep
      shellcheck
      shfmt
      skopeo
      ssm-session-manager-plugin
      terraform
      tree
      vim
      watch
      yamllint
      yarn
    ;

    texlive = super.texlive.combined.scheme-medium;
  } // {
    nix-rebuild = super.writeScriptBin "nix-rebuild" ''
      #!${super.stdenv.shell}
      if ! command -v nix-env &>/dev/null; then
          echo "warning: nix-env was not found in PATH, add nix to userPackages" >&2
          PATH=${self.nix}/bin:$PATH
      fi
      exec nix-env -f '<nixpkgs>' -r -iA userPackages "$@"
    ''; 
  };
}
