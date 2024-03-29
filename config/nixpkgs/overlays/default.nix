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
      direnv
      dive
      editorconfig-core-c
      fd
      ffmpeg
      findutils
      fzy
      gettext
      gist
      git-absorb
      git-lfs
      gitFull
      gnugrep
      go_1_22
      graphviz
      jq
      kubectl
      kubectx
      kustomize
      less
      mkvtoolnix
      nodejs_20
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
      youtube-dl
    ;

    texlive = super.texlive.combined.scheme-medium;
  } // super.lib.optionalAttrs (super.stdenv.isx86_64 || !super.stdenv.isDarwin) {
    inherit (self)
    curlFull;
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
