smartmontools/
==============
Configuration files for the smartmontools package

com.jfnagel.smartctl.plist
--------------------------
This runs `/usr/local/sbin/smartctl --smart=on --saveauto=on` at startup to ensure that SMART operations are enabled.

### Installation:
    $ cp com.jfnagel.smartctl.plist /Library/LaunchDaemons/
    $ sudo chown root:wheel /Library/LaunchDaemons/com.jfnagel.smartd.plist
    $ sudo launchctl load -w /Library/LaunchDaemons/com.jfnagel.smartd.plist

com.jfnagel.smartd.plist
------------------------
This runs `/usr/local/sbin/smartd -n` at startup. The `-n` flag is required to prevent smartd from forking and killing it's parent process, which launchd doesn't like (it will just continually respawn smartd).

### Installation:
    $ cp com.jfnagel.smartctl.plist /Library/LaunchDaemons/
    $ sudo chown root:wheel /Library/LaunchDaemons/com.jfnagel.smartd.plist
    $ sudo launchctl load -w /Library/LaunchDaemons/com.jfnagel.smartd.plist

smartd.conf
-----------
Configuration file for smartd. The current scan is:

`/dev/disk0s2 -a -S on -s (S/../.././02|L/../../6/03) -m EMAIL_ADDRESS`

Caveats
-------
OS X doesn't seem to allow enabling `Automatic Offline` testing, so I haven't bothered with it here.

If you have iStat Pro (widget) or iStat Menus installed, make sure that you disable the features that query the disk, specifically the disk temperature display, because they will disable SMART operations when they finish. This causes smartd to report failures that aren't really failures.
