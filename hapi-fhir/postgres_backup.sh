#!/bin/sh

my_backup() {
 pg_dump -U postgres -Fc -f $2 $1
 if [ $? -ne 0 ] ; then
  echo Could not backup database: $1
  exit 1
 fi

 echo Database backup complete: $1
}

FOLDER=.
if [ $# -ne 0 ] ; then
 FOLDER=$1
 mkdir -p $FOLDER
fi

my_backup fhirtest_dstu2 $FOLDER/fhirtest_dstu2.dump
my_backup fhirtest_dstu3 $FOLDER/fhirtest_dstu3.dump
my_backup fhirtest_r4    $FOLDER/fhirtest_r4.dump
my_backup fhirtest_r5    $FOLDER/fhirtest_r5.dump

