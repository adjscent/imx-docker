#!/bin/bash
# Here are some default settings.
# Make sure DOCKER_WORKDIR is created and owned by current user.

DOCKER_IMAGE_TAG="imx-yocto"
DOCKER_WORKDIR="/opt/yocto"
IMX_RELEASE="imx-5.15.5-1.0.0_desktop"
YOCTO_DIR="${DOCKER_WORKDIR}/${IMX_RELEASE}-build"
MACHINE="imx8mqevk"
DISTRO="imx-desktop-xwayland"
IMAGES="imx-image-desktop"
REMOTE="https://source.codeaurora.org/external/imx/imx-manifest"
BRANCH="imx-linux-honister"
MANIFEST=${IMX_RELEASE}".xml"
