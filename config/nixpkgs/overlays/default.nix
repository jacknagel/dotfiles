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
      git-lfs
      gitFull
      gnugrep
      go_1_16
      jq
      kubectl
      kubectx
      kustomize
      less
      nodejs-14_x
      packer
      ripgrep
      shellcheck
      skopeo
      terraform_1_0
      tree
      vim
      watch
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
