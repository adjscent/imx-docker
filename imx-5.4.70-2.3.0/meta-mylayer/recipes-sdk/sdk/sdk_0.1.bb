SUMMARY = "bitbake-layers recipe"
DESCRIPTION = "Recipe created by bitbake-layers"
LICENSE = "MIT"

SRCREV = "ba3db72b36a3317f4eb3d332a6498b3e4e5e52f6"
PR = "master"
PV = "0.1+git${SRCPV}"
SRC_URI = "git://github.com/Trixarian/sakis3g-source.git"

do_build () {
        chmod +x compile
        ./compile stripped
}

do_install() {
         install -d ${D}$/usr/bin/
         install -m 0755 build/sakis3gz ${D}$/usr/bin/sakis3
         mkdir -p ${D}$/etc/sakis3g.conf
         cp files/sakis3g.conf ${D}$/etc/sakis3g.conf
}