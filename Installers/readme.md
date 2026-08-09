Instructions to build installers for RT (ipk), Windows (NSIS), and Ubuntu (deb)

## cif_ni_cipc_ipk (LabVIEW RT)

1. Update the version in `Installers/cif_ni_cipc_ipk/CONTROL/control` when needed.
2. Place the compiled binary in the IPK template before building:
   `Installers/cif_ni_cipc_ipk/usr/lib/cif/cif_cipc.so.3.3.1`
3. License files for the NI binaries are included under `usr/share/doc/cif-ni-cipc/`
   in both deb and ipk package trees. Update those from `src/resource/` if the
   NI license text changes.
4. Build host needs `binutils`, `tar`, `gzip`, and `python3` (e.g. `sudo apt install binutils tar gzip python3`). The build uses the bundled `Installers/opkg-utils/opkg-build` script; Ubuntu/WSL does not provide an `opkg-utils` apt package.
5. From Windows, run:

   `Installers\build_cif_ni_cipc_ipk.bat`

   Or from WSL/Linux:

   `bash Installers/build_cif_ni_cipc_ipk.sh`

The build stages `Installers/cif_ni_cipc_ipk/` into `Installers/staging/cif_ni_cipc_ipk/`, normalizes text files to LF line endings, packages with `opkg-build`, and writes `cif-ni-cipc_<version>_core2-64.ipk` to `Installers/output/`.

## cif_ni_cipc Windows (NSIS)

1. Update the version in `Installers/Windows/cif_ni_cipc.nsi` when needed.
2. Place `cif_cipc.dll` in `Installers/Windows/resource/`. The NSIS installer shows and installs the NI license from `src/resource/`.
3. Run:

   `Installers\Windows\build_nsis.bat`

## cif_ni_cipc_deb (Ubuntu)

1. Update the version in `Installers/cif_ni_cipc_deb/DEBIAN/control` when needed.
2. Place the compiled binary in `Installers/cif_ni_cipc_deb/usr/lib/cif/cif_cipc.so.3.3.1` before building.

From WSL/Linux:

`bash Installers/build_deb.sh`

The `.deb` is created in `Installers/`.
