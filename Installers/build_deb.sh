#!/bin/sh

 cd ./cif_ni_cipc_deb

# Extract the version number from the control file
# This assumes the file is at ./DEBIAN/control
PKG_VERSION=$(grep "^Version:" ./DEBIAN/control | cut -d' ' -f2)

# Verify we actually got a version number
if [ -z "$PKG_VERSION" ]; then
    echo "Error: Could not find version in ./DEBIAN/control"
    exit 1
fi

# Create the deb using the variable in the filename
dpkg-deb --build --root-owner-group ./ cif-ni-cipc.${PKG_VERSION}.deb

echo "Successfully created ../cif-ni-cipc.${PKG_VERSION}.deb"
