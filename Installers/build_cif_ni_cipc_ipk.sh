#!/usr/bin/env bash
# End-to-end build for the cif_ni_cipc_ipk LabVIEW RT package.
#
# Workflow:
#   1. Copy the checked-in IPK template into a staging directory
#   2. Normalize text files to LF line endings for Linux/RT
#   3. Create the .ipk archive with opkg-build and move it to Installers/output/
#
# Uses Installers/opkg-utils/opkg-build when opkg-build is not installed system-wide.
# Requires binutils (ar), tar, gzip, and python3.
#
# Usage:
#   bash Installers/build_cif_ni_cipc_ipk.sh
#
# On Windows, prefer Installers/build_cif_ni_cipc_ipk.bat which invokes this
# script through WSL.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IPK_TEMPLATE="${SCRIPT_DIR}/cif_ni_cipc_ipk"
STAGING_DIR="${SCRIPT_DIR}/staging/cif_ni_cipc_ipk"
OUTPUT_DIR="${SCRIPT_DIR}/output"
BUILD_IPK="${SCRIPT_DIR}/build_ipk.sh"
BINARY_NAME="cif_cipc.so.3.3.1"

if [[ ! -d "${IPK_TEMPLATE}" ]]; then
  echo "Error: IPK template not found at ${IPK_TEMPLATE}" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "Error: python3 is required to normalize line endings" >&2
  exit 1
fi

if ! command -v ar >/dev/null 2>&1; then
  echo "Error: ar not found. Install binutils (e.g. apt install binutils)." >&2
  exit 1
fi

BUNDLED_OPKG_BUILD="${SCRIPT_DIR}/opkg-utils/opkg-build"
if ! command -v opkg-build >/dev/null 2>&1 && [[ ! -f "${BUNDLED_OPKG_BUILD}" ]]; then
  echo "Error: opkg-build not found and bundled script missing at ${BUNDLED_OPKG_BUILD}" >&2
  exit 1
fi

if [[ ! -f "${IPK_TEMPLATE}/usr/lib/cif/${BINARY_NAME}" ]]; then
  echo "Error: Compiled binary not found at ${IPK_TEMPLATE}/usr/lib/cif/${BINARY_NAME}" >&2
  echo "Place ${BINARY_NAME} in the IPK template before building." >&2
  exit 1
fi

# Stage a clean copy of the template so the source tree is never modified.
echo "Staging IPK template..."
rm -rf "${SCRIPT_DIR}/staging"
mkdir -p "${STAGING_DIR}"
cp -a "${IPK_TEMPLATE}/." "${STAGING_DIR}/"

# Ensure shell scripts, Python, conf files, etc. use Linux line endings.
echo "Normalizing line endings to LF..."
python3 "${SCRIPT_DIR}/normalize_ipk_line_endings.py" "${STAGING_DIR}"

# Build the IPK from the staged tree.
echo "Building IPK..."
OUTPUT_PARENT="$(dirname "${STAGING_DIR}")"
IPK_PATH="$(
  bash "${BUILD_IPK}" "${STAGING_DIR}" "${OUTPUT_PARENT}"
)"

mkdir -p "${OUTPUT_DIR}"
FINAL_IPK="${OUTPUT_DIR}/$(basename "${IPK_PATH}")"
mv -f "${IPK_PATH}" "${FINAL_IPK}"

echo "Successfully created ${FINAL_IPK}"
