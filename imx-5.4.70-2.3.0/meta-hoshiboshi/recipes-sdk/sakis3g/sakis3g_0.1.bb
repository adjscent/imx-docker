SUMMARY = "bitbake-layers recipe"
DESCRIPTION = "Recipe created by bitbake-layers"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# need this for github
SRC_URI = "git://github.com/Trixarian/sakis3g-source.git"
SRCREV = "ba3db72b36a3317f4eb3d332a6498b3e4e5e52f6"
S = "${WORKDIR}/git"
#

RDEPENDS_${PN} += "bash"

do_build() {
         chmod +x ${S}/compile
         ${S}/compile
}

do_install() {
         install -d ${D}${bindir}
         install -m 0755 ${S}/build/sakis3gz ${D}${bindir}/sakis3g

         mkdir -p ${D}${sysconfdir}
         install -m 0644 ${S}/files/sakis3g.conf ${D}${sysconfdir}/sakis3g.conf
        # {
        #     echo 'USBDRIVER="option"';
        #     echo 'OTHER="USBMODEM"';
        #     echo 'USBMODEM=" "';
        #     echo 'USBINTERFACE="2"';
        #     echo 'CUSTOM_APN=" "';
        #     echo 'APN_USER=" "';
        #     echo 'APN_PASS=" "';
        # } > /etc/sakis3g.conf
}