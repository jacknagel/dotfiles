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
      dive
      editorconfig-core-c
      fd
      fzy
      gist
      git-lfs
      gitFull
      gnugrep
      go
      jq
      kubectl
      kubectx
      kustomize
      less
      nodejs-14_x
      powershell
      ripgrep
      shellcheck
      terraform
      tree
      vim
      watch
      youtube-dl
    ;

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
