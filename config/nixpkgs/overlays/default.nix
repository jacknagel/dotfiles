self: super:

{
  userPackages = super.userPackages or {} // {
    inherit (self)
      aws-vault
      awscli2
      bash-completion
      bashInteractive_5
      certigo
      curlFull
      direnv
      dive
      editorconfig-core-c
      fd
      fzy
      gist
      git-absorb
      git-lfs
      gitFull
      gnugrep
      go_1_17
      graphviz
      jq
      kubectl
      kubectx
      kustomize
      less
      nodejs-16_x
      packer
      ripgrep
      shellcheck
      skopeo
      ssm-session-manager-plugin
      terraform
      tree
      vim
      watch
      yamllint
      youtube-dl
    ;

    texlive = super.texlive.combined.scheme-medium;

    inherit (self)
      cacert
      nix;

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
