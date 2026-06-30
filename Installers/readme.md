Instructions to build installers for RT (ipk) and Ubuntu (deb)

1. Update the version in both control files (ipk and deb).
2. Place the compiled binary in the package payload:
   - deb: `cif_ni_cipc_deb/usr/lib/cif/cif_cipc.so.3.3.1`
   - ipk: `cif_ni_cipc_ipk/data/usr/lib/cif/cif_cipc.so.3.3.1`
3. License files for the NI binaries are included under `usr/share/doc/cif-ni-cipc/`
   in both deb and ipk package trees. Update those from `src/resource/` if the
   NI license text changes.
4. For Windows, place `cif_cipc.dll` in `Installers/Windows/resource/`. The NSIS
   installer shows and installs the NI license from `src/resource/`.
5. In terminal run `<wsl>` to enter Windows Subsystem for Linux.
6. Copy the installers directory to the home directory:
   `<cp -r /mnt/d/dev/Packages/NI_CIPC/Installers/ ~/installers>`
7. Run the builds: `<bash ~/installers/build_deb.sh>` and `<bash ~/installers/build_ipk.sh>`
8. Copy the files back to a mounted location:
   `<cp -r ~/installers/cif-ni-cipc.0.1.1.0.ipk /mnt/d/dev/builds/installers/>`
   `<cp -r ~/installers/cif-ni-cipc.0.1.1.0.deb /mnt/d/dev/builds/installers/>`
9. Delete the new directory: `<rm -rf ~/installers>`

For Windows, run `Installers/Windows/build_nsis.bat` from a machine with NSIS installed.
