#!/bin/sh
pushd ./data/
tar --numeric-owner --group=0 --owner=0 -czf ../data.tar.gz ./*
popd

#pushd /home/admin/ipk_maker/adp-vsim/control/
pushd ./control/
tar --numeric-owner --group=0 --owner=0 -czf ../control.tar.gz ./*
popd

#pushd /home/admin/ipk_maker/adp-vsim/
tar --numeric-owner --group=0 --owner=0 -cf ../cif_ni_cipc.0.1.0.ipk ./debian-binary ./data.tar.gz ./control.tar.gz
rm ./data.tar.gz
rm ./control.tar.gz
#popd
