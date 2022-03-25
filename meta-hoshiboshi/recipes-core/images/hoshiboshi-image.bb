SUMMARY = "Hoshiboshi production image"

LICENSE = "MIT"

inherit core-image

# Note: Systemd is already enabled
## Remove python2 (does not work)
# IMAGE_INSTALL_remove += "python "
# PACKAGE_EXCLUDE_pn-target_image = " python "
# PNBLACKLIST[python] = "Python2 Not supported by this distro."
## Set features
IMAGE_FEATURES += " ssh-server-openssh "
## Important system packages
IMAGE_INSTALL_append += " packagegroup-core-boot zlib "
IMAGE_INSTALL_append += " git inotify-tools ethtool memtester bison libpcap ppp wget curl ca-certificates nano libqmi tcpdump python3-pip xz socat gawk iperf3"
# Custom modifications
IMAGE_INSTALL_append += " python-helloworld "

# Need this for proper apt-get
PREFERRED_VERSION_gnupg ?= "2.1.11"
PACKAGE_CLASSES ?= "package_deb"
IMAGE_INSTALL_append += " gnupg "

# Use this to remove old images in deploy
RM_OLD_IMAGE = "1"

# Set rootfs size
IMAGE_ROOTFS_SIZE ?= "8192"

# IMAGE_FEATURES += " allow-empty-password allow-root-login bash-completion-pkgs dbg-pkgs debug-tweaks dev-pkgs doc doc-pkgs eclipse-debug empty-root-password hwcodecs nfs-client nfs-server package-management post-install-logging ptest-pkgs qtcreator-debug read-only-rootfs splash src-pkgs ssh-server-dropbear ssh-server-openssh stateless-rootfs staticdev-pkgs tools-debug tools-profile tools-sdk tools-testapps x11 x11-base x11-sato"

# Change root user password
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