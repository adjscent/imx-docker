SUMMARY = "Hoshiboshi development image"

inherit core-image
require hoshiboshi-image.bb

IMAGE_FEATURES += " git  "