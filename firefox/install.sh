#! /bin/sh

scriptpath=$(readlink -f $0)
installer_dir=$(dirname $scriptpath)
builddir=$(mktemp -d /tmp/keepassxcXXX)/_build

# Install Flatpak sandbox override
flatpak --user override --talk-name=org.freedesktop.Flatpak org.mozilla.firefox

# Firefox's native messaging directory when distributed via Flatpak.
native_messaging_dir=$HOME/.var/app/org.mozilla.firefox/.mozilla/native-messaging-hosts

# Install the shim and native messaging manifest
mkdir -p $builddir
cp -r $installer_dir/native-messaging-hosts $builddir/
sed -i "s|%HOME%|$HOME|g" $builddir/native-messaging-hosts/org.keepassxc.keepassxc_browser.json

if [ ! -d "$native_messaging_dir" ]; then
    mkdir -p $native_messaging_dir
fi

install -m 644 $builddir/native-messaging-hosts/org.keepassxc.keepassxc_browser.json $native_messaging_dir
install -m 0755 $builddir/native-messaging-hosts/keepassxc-proxy-shim.sh $native_messaging_dir
rm -rf $builddir
