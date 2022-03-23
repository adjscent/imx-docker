#!/bin/bash -xe
# This script will run into container
# source own
SCRIPT=$(realpath $0)
SCRIPTPATH=$(dirname $SCRIPT)
source ${SCRIPTPATH}/env.sh

# special github stuff as git:// is no longer supported by github
git config --global url.https://github.com/.insteadOf git://github.com/
#

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

EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-release.sh -b build_${DISTRO}

# Build
rm -fr ${YOCTO_DIR}/sources/meta-hoshiboshi
cp -fr ${SCRIPTPATH}/meta-hoshiboshi/ ${YOCTO_DIR}/sources/meta-hoshiboshi
bitbake-layers add-layer ${YOCTO_DIR}/sources/meta-hoshiboshi

bitbake ${IMAGES}
echo "Image is here ${YOCTO_DIR}/${DISTRO}/tmp/deploy/images/${MACHINE}/${IMAGES}-${MACHINE}.wic.bz2"
