#!/bin/bash -xe
# This script will run into container
# source own
SCRIPT=$(realpath $0)
SCRIPTPATH=$(dirname $SCRIPT)
source ${SCRIPTPATH}/env.sh

# ignore color
git config --global color.ui false
# special github stuff as git:// is no longer supported by github
git config --global url.https://github.com/.insteadOf git://github.com/
# faster git
git config --global submodule.fetchJobs 20

#
mkdir -p ${YOCTO_DIR}
cd ${YOCTO_DIR}

# Init
if [ ! -f "imx-setup-release.sh" ]; then
    repo init \
        -u ${REMOTE} \
        -b ${BRANCH} \
        -m ${MANIFEST}

    repo sync -j16
fi

BUILDDIR="${YOCTO_DIR}/build_${DISTRO}"

EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-release.sh -b build_${DISTRO}

# Build
echo "UBOOT_CONFIG = \"sd fspi emmc\"" >>"${BUILDDIR}/conf/local.conf"

# u-boot only
bitbake -c clean u-boot-imx
bitbake -c deploy u-boot-imx
