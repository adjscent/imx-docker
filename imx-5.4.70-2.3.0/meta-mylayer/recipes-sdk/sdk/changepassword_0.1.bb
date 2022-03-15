SUMMARY = "bitbake-layers recipe"
DESCRIPTION = "Recipe created by bitbake-layers"
HOMEPAGE = ""
LICENSE = "MIT"
SECTION = ""
DEPENDS = ""
LIC_FILES_CHKSUM = ""

inherit extrausers

# Change root password (note the capital -P)
EXTRA_USERS_PARAMS = "\
  usermod -P 'root' root \
  "