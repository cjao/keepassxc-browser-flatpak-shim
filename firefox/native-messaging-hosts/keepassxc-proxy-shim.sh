#! /bin/sh

if [ -f /.flatpak-info ]; then
    flatpak-spawn --host /var/lib/flatpak/exports/bin/org.keepassxc.KeePassXC "$@"
fi
