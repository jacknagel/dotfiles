# vim:ft=sh
# shellcheck shell=bash

NIX_PROFILE=${NIX_PROFILE:-$HOME/.nix-profile}
[ -r "$NIX_PROFILE/etc/profile.d/nix.sh" ] && . "$NIX_PROFILE/etc/profile.d/nix.sh"
# shellcheck source=bashrc
[ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc"
