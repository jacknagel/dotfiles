dotfiles/ddclient
=================
Configuration files for the ddclient package

### Installation

```
cp ddclient.conf /usr/local/etc/ddclient/

sudo cp homebrew.jfn.ddclient.plist /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/homebrew.jfn.ddclient.plist
sudo launchctl load -w /Library/LaunchDaemons/homebrew.jfn.ddclient.plist

```
