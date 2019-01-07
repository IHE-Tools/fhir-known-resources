#!/bin/sh

check_args() {
 if [ $# -ne 1 ]; then
  echo "Usage: <working folder>"
  exit 1
 fi
}

check_args $*

FOLDER=$1
mkdir -p $FOLDER
pushd $FOLDER

P=ftp://ftp.ihe.net/Connectathon/test_data/ITI-profiles/mCSD-test-data/FHIR_Resources

wget -r $P
