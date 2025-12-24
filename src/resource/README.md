# CIPC-Channels
Wrappers around the NI dll for CIPC API
cif_cipc.dll previously was to be installed in the ..\LabVIEW 20xx\resource\ directory however the relative path is an issue with PPLs.  Now:
cif_cipc.dll must be installed in the C:\Program Files\CIF_Foundation\Libraries\ directory.
cif_cipc.so.3.3.1 must be installed on the linux target and a symlink created at /usr/lib/x86_64-linux-gnu/cif_cipc.so
