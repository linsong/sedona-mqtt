#! /usr/bin/env bash

source adm/unix/init.sh 
makeunixvm && makesedonac && sedonac scode/x86-test.xml && svm scode/x86-test.scode -utest communityMQTT
