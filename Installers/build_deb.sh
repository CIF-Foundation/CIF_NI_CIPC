#!/usr/bin/env bash
# End-to-end build for the cif_ni_cipc Debian package.
#
# dpkg-deb requires DEBIAN/ mode 0755-0775. WSL mounts of the Windows repo
# report 777 and ignore chmod, so this script copies the template to a native
# Linux temp directory, fixes permissions there, then writes the .deb to
# Installers/output/.
#
# Usage:
#   bash Installers/build_deb.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEB_TEMPLATE="${SCRIPT_DIR}/cif_ni_cipc_deb"
OUTPUT_DIR="${SCRIPT_DIR}/output"
BINARY_NAME="cif_cipc.so.3.3.1"

if [[ ! -d "${DEB_TEMPLATE}/DEBIAN" ]]; then
  echo "Error: Debian template not found at ${DEB_TEMPLATE}" >&2
  exit 1
fi

if ! command -v dpkg-deb >/dev/null 2>&1; then
  echo "Error: dpkg-deb not found. Install dpkg (e.g. apt install dpkg)." >&2
  exit 1
fi

if [[ ! -f "${DEB_TEMPLATE}/usr/lib/cif/${BINARY_NAME}" ]]; then
  echo "Error: Compiled binary not found at ${DEB_TEMPLATE}/usr/lib/cif/${BINARY_NAME}" >&2
  echo "Place ${BINARY_NAME} in the Debian template before building." >&2
  exit 1
fi

PKG="$(grep '^Package:' "${DEB_TEMPLATE}/DEBIAN/control" | awk '{print $2}')"
VERSION="$(grep '^Version:' "${DEB_TEMPLATE}/DEBIAN/control" | awk '{print $2}')"
ARCH="$(grep '^Architecture:' "${DEB_TEMPLATE}/DEBIAN/control" | awk '{print $2}')"
if [[ -z "${PKG}" || -z "${VERSION}" || -z "${ARCH}" ]]; then
  echo "Error: Could not read Package, Version, and Architecture from ${DEB_TEMPLATE}/DEBIAN/control" >&2
  exit 1
fi

STAGE_ROOT="$(mktemp -d)"
trap 'rm -rf "${STAGE_ROOT}"' EXIT
STAGING_DIR="${STAGE_ROOT}/cif_ni_cipc_deb"

echo "Staging Debian template on a native Linux filesystem..."
mkdir -p "${STAGING_DIR}"
cp -a "${DEB_TEMPLATE}/." "${STAGING_DIR}/"

# Repository placeholders must not install on the target.
find "${STAGING_DIR}" -name '.gitkeep' -type f -delete

if command -v python3 >/dev/null 2>&1; then
  python3 "${SCRIPT_DIR}/normalize_ipk_line_endings.py" "${STAGING_DIR}"
fi

# dpkg-deb rejects DEBIAN/ at 0777, which is what WSL/drvfs reports.
find "${STAGING_DIR}" -type d -exec chmod 0755 {} +
find "${STAGING_DIR}" -type f -exec chmod 0644 {} +
chmod 0755 "${STAGING_DIR}/DEBIAN"
chmod 0644 "${STAGING_DIR}/DEBIAN/control"
for script in preinst postinst prerm postrm; do
  if [[ -f "${STAGING_DIR}/DEBIAN/${script}" ]]; then
    chmod 0755 "${STAGING_DIR}/DEBIAN/${script}"
  fi
done
if [[ -f "${STAGING_DIR}/usr/lib/cif/${BINARY_NAME}" ]]; then
  chmod 0755 "${STAGING_DIR}/usr/lib/cif/${BINARY_NAME}"
fi

mkdir -p "${OUTPUT_DIR}"
DEB_FILENAME="${OUTPUT_DIR}/${PKG}_${VERSION}_${ARCH}.deb"

echo "Building Debian package..."
dpkg-deb --build --root-owner-group "${STAGING_DIR}" "${DEB_FILENAME}"

echo "Successfully created ${DEB_FILENAME}"
