# NI CIPC Binaries

Wrappers around the NI dll for the CIPC API.

## License

**The compiled binary libraries in this directory are not covered by the repository's Apache 2.0 license.**

These files (`cif_cipc.dll`, `cif_cipc.so`, and versioned variants such as
`cif_cipc.so.3.3.1`) remain under National Instruments' [Source Code
License](NI-Source-Code-License.txt) (Addendum A of the NI General Purpose
Software License Agreement). See [LICENSE](LICENSE) in this directory.

Copyright National Instruments Corporation.

## Install locations

`cif_cipc.dll` previously was to be installed in the `..\LabVIEW 20xx\resource\`
directory however the relative path is an issue with PPLs. Now:

- `cif_cipc.dll` must be installed in the `C:\Program Files\CIF_Foundation\Libraries\` directory.
- `cif_cipc.so.3.3.1` must be installed on the linux target and a symlink created at `/usr/lib/cif_cipc.so`

The cif-ni-cipc binary installer packages these files for Windows, Ubuntu, and Linux RT.

## Relationship to CIF NI CIPC

The LabVIEW wrapper code in the rest of this repository is licensed separately
by CIF Foundation under Apache 2.0 — see the [repository README](../../README.md).

When contributing, do not relicense or replace NI copyright notices for these
binaries unless you have rights from NI to do so.
