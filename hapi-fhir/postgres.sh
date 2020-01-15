#!/bin/sh

my_createdb() {
 psql -U postgres --command="SELECT version();" $1 > /dev/null 2>&1
 if [ $? -eq 0 ] ; then
  echo Dropping existing database: $1
  dropdb -U postgres $1
  if [ $? -ne 0 ] ; then
   echo Could not drop database: $1
   exit 1
  fi
 fi

 createdb -U postgres $1
 if [ $? -ne 0 ] ; then
  echo Could not create database: $1
  exit 1
 fi

 echo Created database $1
 psql -U postgres --list | grep $1

}

my_createdb fhirtest_dstu2
my_createdb fhirtest_dstu3
my_createdb fhirtest_r4
my_createdb fhirtest_r5

