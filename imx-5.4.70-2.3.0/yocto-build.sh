#!/bin/bash -x
# This script will run into container

# source the common variables

SCRIPT=$(realpath $0)
SCRIPTPATH=$(dirname $SCRIPT)

. $SCRIPTPATH/env.sh

#

mkdir -p ${YOCTO_DIR}
cd ${YOCTO_DIR}

# Init

repo init \
    -u ${REMOTE} \
    -b ${BRANCH} \
    -m ${MANIFEST}

repo sync -j16

# source the yocto env

EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-release.sh -b build_${DISTRO}

# new additions

cp -fr $SCRIPTPATH/meta-mylayer/ ${YOCTO_DIR}/sources/meta-mylayer

bitbake-layers add-layer ${YOCTO_DIR}/sources/meta-mylayer

# Build

bitbake ${IMAGES}
