# Contributing to CIF-NI-CIPC

Thank you for your interest in contributing to CIF NI CIPC.

## License

By submitting a contribution to this repository, you agree that your contribution
will be licensed under the [Apache License, Version 2.0](LICENSE), the same
license that covers most of this project.

**Exception:** Compiled NI CIPC binary libraries under `src/resource/` (for
example, `cif_cipc.dll` and `cif_cipc.so*`) are licensed by National
Instruments under the [NI Source Code License](src/resource/NI-Source-Code-License.txt)
(GPSLA Addendum A), not Apache 2.0. Do not submit changes that would relicense
NI binary material unless you have the right to do so. Prefer opening an issue
to discuss changes that touch the NI CIPC binaries.

## How to contribute

1. Fork the repository and create a branch for your change.
2. Make your changes and test them in LabVIEW where applicable.
3. Open a pull request with a clear description of the problem and solution.
4. Respond to review feedback as needed.

## Pull request guidelines

- Keep changes focused on a single topic when possible.
- Update documentation when behavior or public APIs change.
- Do not include unrelated formatting or refactoring.
- Ensure VIPM package metadata (copyright, license) remains accurate if you
  touch `VIPM/CIF_CIPC.vipb`.

## Questions

For questions about contributing, open an issue in this repository or contact
CIF Foundation through [cif-foundation.com](https://cif-foundation.com).
