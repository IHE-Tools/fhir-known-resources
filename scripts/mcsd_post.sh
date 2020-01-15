#!/bin/sh

check_args() {
 if [ $# != 1 ]; then
  echo "Usage: <working folder>"
  exit 1
 fi
}

check_folder() {
 if [ ! -e $1 ]; then
  echo "The folder $1 should already exist and contain subfolders with resource data"
  echo "Did you run the appropriate wget script?"
  echo "Script put.sh exiting"
  exit 1
 fi
}

create_empty_folder() {
 if [ -e $1 ] ; then
  rm -r $1
 fi
 mkdir -p $1
}

check_args $*

FOLDER=$1/mCSD_FHIR-R4_Resources
check_folder $FOLDER
create_empty_folder ../mcsd/logs

AT='@'
HEADER="Content-Type: application/fhir+xml"

for RESOURCE in HealthcareService Location Organization Practitioner PractitionerRole ; do
 echo $RESOURCE `date`
 for f in $FOLDER/$RESOURCE/*xml ; do
  component=`./last_path_component.sh $f`
  echo $f $component
  ./post_resource.sh $RESOURCE $f ../mcsd/logs/$component.txt
  if [ $? != 0 ] ; then
   echo Failed to post resource: $RESOURCE $f
   exit 1
  fi
 done
 echo ""
done
