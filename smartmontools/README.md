# dotfiles/smartmontools
Configuration files for the smartmontools package

## Installation

```
cp smartd.conf /usr/local/etc/
sudo cp homebrew.jfn.smartctl.plist /Library/LaunchAgents/
sudo chown root:wheel /Library/LaunchAgents/homebrew.jfn.smartctl.plist
sudo launchctl load -w /Library/LaunchAgents/homebrew.jfn.smartctl.plist
sudo cp homebrew.jfn.smartd.plist /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/homebrew.jfn.smartd.plist
sudo launchctl load -w /Library/LaunchDaemons/homebrew.jfn.smartd.plist
```

## Notes
 - OS X doesn't seem to accept "Automatic Offline" testing
 - iStat {Pro, Menus} may sometimes disable SMART operations
