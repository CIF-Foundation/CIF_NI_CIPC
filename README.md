# CIF_NI_CIPC

Wrappers around the NI dll for CIPC (circular interprocess communication) library.

## License

Copyright 2024-2026 CIF Foundation

This repository uses **two licenses**:

| Scope | License |
|---|---|
| All files **except** compiled NI CIPC binaries under `src/resource/` | [Apache License 2.0](LICENSE) (CIF Foundation) |
| `src/resource/cif_cipc.dll`, `cif_cipc.so*` | [NI Source Code License](src/resource/NI-Source-Code-License.txt) (National Instruments, GPSLA Addendum A) |

See [NOTICE](NOTICE) for third-party attributions and [src/resource/README.md](src/resource/README.md) for binary install locations and NI license details.

## Contributing

Contributions are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## Binary installation

The LabVIEW wrappers require the NI CIPC binary library to be installed separately:

- **Windows:** `cif_cipc.dll` in `C:\Program Files\CIF_Foundation\Libraries\`
- **Linux / Linux RT:** `cif_cipc.so.3.3.1` on the target with a symlink at `/usr/lib/cif_cipc.so`

Installers (VIPM for the LabVIEW package; NSIS/deb/ipk for the binary) install these files in the correct locations.
