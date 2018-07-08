#! /usr/bin/env bash
# 
# this script will patch sedona environment to support test communityMQTT kit 
# 

echo "patching platforms/src/generic/unix/generic-unix.xml ..."
sed -i'' -e '\#<nativeKit depend="platUnix 1.0+" />#a \
\ \ \ \ <nativeKit depend="communityMQTT 1.0+" /> \
' platforms/src/generic/unix/generic-unix.xml
sed -i'' -e '\#<nativeSource path="/src/kits/datetimeStd/native/std"#a \
\ \ \ \ <nativeSource path="/src/kits/communityMQTT/native" /> \
' platforms/src/generic/unix/generic-unix.xml

echo "patching scode/x86-test.xml ..."
sed -i'' -e '\#<depend on="types 1.2"   />#a \
\ \ <depend on="communityMQTT 1.2" /> \
  ' scode/x86-test.xml

echo "patching src/kits/dir.xml ..."
sed -i'' -e '\#<target name="logManager" />#a \
\ \ <target name="communityMQTT" /> \
  ' src/kits/dir.xml

echo "patching adm/unix/compileunix.py ..."
sed -i'' -e 's# -O2# -O2 -pthread#' adm/unix/compileunix.py
