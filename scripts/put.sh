#!/bin/sh

check_args() {
 if [ $# -lt 1 ]; then
  echo "Usage: <working folder> [<server url>]"
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

set_base () {
#BASE="http://localhost:8080/hapi-fhir-jpaserver/baseDstu3"
#BASE="http://fhirtest.uhn.ca/baseDstu3"
 BASE="http://localhost:8080/connectathon-rw/baseDstu3"
 if [ $# -ge 2 ] ; then
  BASE=$2
 fi
}

check_args $*

FOLDER=$1/mCSD_FHIR-R4_Resources
check_folder $FOLDER

set_base $*

echo BASE: $BASE

pushd $FOLDER

AT='@'
HEADER="Content-Type: application/fhir+xml"

for RESOURCE in HealthcareService Location Organization Practitioner PractitionerRole ; do
 echo $RESOURCE `date`
 URL="$BASE/$RESOURCE?_format=xml&_pretty=true"
 for f in $RESOURCE/*xml ; do
  rm -f /tmp/x.txt /tmp/y.txt
  echo $f
  FILE=$AT$f
  echo ""
  echo curl -s -X POST -H "$HEADER" -i --data-binary $FILE -w '%{http_code}' -o /tmp/x.txt "$URL"
       curl -s -X POST -H "$HEADER" -i --data-binary $FILE -w '%{http_code}' -o /tmp/x.txt "$URL" > /tmp/y.txt
  if [ $? != 0 ] ; then
    echo "Unable to POST resource to server"
    echo Exiting now
    exit
   fi


  echo ""
  echo "\t" $FILE
  echo /tmp/x.txt `cat /tmp/x.txt`
  echo /tmp/y.txt `cat /tmp/y.txt`
  echo ""
 done
 echo ""
done
