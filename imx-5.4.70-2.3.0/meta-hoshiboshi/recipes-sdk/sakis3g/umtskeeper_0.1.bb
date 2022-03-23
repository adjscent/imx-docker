SUMMARY = "bitbake-layers recipe"
DESCRIPTION = "Recipe created by bitbake-layers"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd
SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE_${PN} = "umtskeeper.service"

SRC_URI_append = "file://umtskeeper \
           file://umtskeeper.service \
           "

do_install_append() {
    install -d ${D}${bindir}
    install -m 0755 umtskeeper ${D}${bindir}

    install -d ${D}/${systemd_unitdir}/system
    install -m 0644 umtskeeper.service ${D}${systemd_unitdir}/system
}