#!/bin/sh

. ./base_url.sh

RESOURCE=""

AT='@'
HEADER="Content-Type: application/fhir+xml"

check_args() {
 if [ $# != 2 ] ; then
  echo "Arguments: resource log_file"
  echo "           log_file is log information from the curl command"
  exit 1
 fi
}

get_resource() {
 echo $1 $2
 URL="$BASE_URL/$1?_format=xml&_pretty=true"
 LOG=$2
 echo $URL
 echo $LOG
# HTTP_STATUS=`curl -s -X GET -o $LOG "$URL"`
# if [ $? != 0 ] ; then
#  echo "The curl command itself failed."
#  echo "The get_resource.sh script will exit with an error code."
#  exit 1
# fi

# if [ $HTTP_STATUS != 200 ] ; then
#  echo "The GET request returned an unrecognized result: $HTTP_STATUS"
#  echo "The get_resource.sh script will exit with an error code."
#  exit 1
# fi

}

#check_args $*
get_resource $*
