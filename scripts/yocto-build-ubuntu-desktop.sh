#!/bin/bash -e
# This script will run into container
# source own
SCRIPT=$(realpath $1)
# SCRIPTPATH=$(dirname $SCRIPT)
source ${SCRIPT}

# set fake user
git config --global user.name 'test'
git config --global user.email '<>'

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
if [ ! -f "imx-setup-desktop.sh" ]; then
    repo init \
        -u ${REMOTE} \
        -b ${BRANCH} \
        -m ${MANIFEST}

    repo sync -j16
fi

BUILDDIR="${YOCTO_DIR}/build_${DISTRO}"

# MACHINE="${MACHINE}" DISTRO="${DISTRO}" . setup-environment "build_${DISTRO}"
# bug in imx-setup-release. remove to reconfigure
rm -fr ${YOCTO_DIR}/build_${DISTRO}/conf

EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-desktop.sh -b "build_${DISTRO}"

bitbake imx-image-desktop
