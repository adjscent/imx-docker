#!/bin/bash
# Here are some default settings.
# Make sure DOCKER_WORKDIR is created and owned by current user.

# Docker

DOCKER_IMAGE_TAG="imx-yocto"
DOCKER_WORKDIR="/opt/yocto"

# Yocto

IMX_RELEASE="imx-5.4.70-2.3.0"

YOCTO_DIR="${DOCKER_WORKDIR}/${IMX_RELEASE}-build"

MACHINE="imx8qxprom5620a1"
DISTRO="fsl-imx-xwayland"
IMAGES="imx-image-core"

REMOTE="https://github.com/ADVANTECH-Corp/adv-arm-yocto-bsp.git"
BRANCH="imx-linux-zeus"
MANIFEST=${IMX_RELEASE}".xml"

