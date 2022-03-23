SUMMARY = "Hoshiboshi production image"

LICENSE = "MIT"

inherit core-image

# Note: Systemd is already enabled
PACKAGE_EXCLUDE_pn-target_image = " python"
IMAGE_FEATURES += " ssh-server-openssh tools-debug package-management hwcodecs dev-pkgs "
CORE_IMAGE_EXTRA_INSTALL += " inotify-tools ethtool memtester git bison libpcap ppp wget curl ca-certificates nano tcpdump python3-pip"
# Custom modifications
CORE_IMAGE_EXTRA_INSTALL += " python-helloworld sakis3g"

# Need this for proper apt-get
PREFERRED_VERSION_gnupg ?= "2.1.11"
PACKAGE_CLASSES ?= "package_deb"
IMAGE_INSTALL_append = " gnupg "

# Use this to remove old images in deploy
RM_OLD_IMAGE = "1"

IMAGE_ROOTFS_SIZE ?= "8192"

# IMAGE_FEATURES += " allow-empty-password allow-root-login bash-completion-pkgs dbg-pkgs debug-tweaks dev-pkgs doc doc-pkgs eclipse-debug empty-root-password hwcodecs nfs-client nfs-server package-management post-install-logging ptest-pkgs qtcreator-debug read-only-rootfs splash src-pkgs ssh-server-dropbear ssh-server-openssh stateless-rootfs staticdev-pkgs tools-debug tools-profile tools-sdk tools-testapps x11 x11-base x11-sato"

inherit extrausers
ROOTPASSWORD = "root"
ROOTUSERNAME = "root"
pkg_postinst_${PN} () {
  #!/bin/sh -e
  # Note: Destination directory is available during boot
  #
  # process and unset at first boot
  if [ -z $D ]; then
    usermod -p `openssl passwd -6 ${ROOTPASSWORD}` ${ROOTUSERNAME};
  fi
}