# KeepassXC-Browser shim for flatpaked browsers

The [KeepassXC Browser
extension](https://github.com/keepassxreboot/keepassxc-browser)
removes the need to manually copy-paste passwords into web
sites. Users no longer risk accidentally selecting the wrong database
entry to copy, and the browser extension is better than humans at
positively identifying websites. However, it is [well
known](https://github.com/flatpak/xdg-desktop-portal/issues/655) that
the KeepassXC browser extension does not currently work when both
[KeepassXC](https://github.com/keepassxreboot/keepassxc) and the web
browser are running in Flatpak containers.

Until the linked issue is resolved definitively, this repo provides a
temporary workaround by installing a shim in the Firefox's
native-messaging manifest directory to invoke KeepassXC using
`flatpak-spawn --host`. The browser's Flatpak permissions are also
relaxed to allow invoking programs on the host and accessing the
system `/tmp` directory, where KeepassXC's browser proxy maintains its
IPC socket.

## Instructions for Firefox

1. Inspect and run the `install.sh` script in the `firefox`
   directory. Avoid running scripts off the internet if you don't
   understand what they are trying to do.

2. Enable browser integration in KeepassXC settings. This will spawn a
  server to mediate between the KeepassXC database and browser
  extensions. There is **no need** to check the box for Firefox. The
  browser-specific checkboxes merely install a native messaging manifest
  file in the appropriate location for the browser, which in this case
  is handled by the first step.


## Notes

One might argue that the use of `flatpak-spawn --host` weakens the
security of the browser. However, one should keep in mind the big
picture. Firefox uses Flatpak largely as a distribution mechanism for
users' convenience, not to provide security boundaries, and users of
the Flatpak already need to accept [reduced internal browser
protections](https://bugzilla.mozilla.org/show_bug.cgi?id=1756236). Relaxing
an externally imposed sandbox such as Flatpak's does not undermine the
native messaging protocol's inherent restrictions since it does not
change how a browser runs its extensions.
