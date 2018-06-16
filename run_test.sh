#! /usr/bin/env bash

(source adm/unix/init.sh && python adm/unix/makeunixvm.py && python adm/makesedonac.py && ./bin/sedonac.sh scode/x86-test.xml && ./bin/svm scode/x86-test.scode -utest communityMQTT)
