#!/bin/sh

#check_args() {
# if [ $# != 1 ] ; then
#  echo "Arguments: folder"
#  echo "           folder contains one or more xml Structure Definition resources"
#  exit 1
# fi
#
# if [ ! -e $1 ] ; then
#  echo "The folder $1 does not exist; exiting"
#  exit 1
# fi
#}

#check_args $*

#touch  ../tmp ../logs
#rm -rf ../tmp ../logs
#mkdir  ../tmp ../logs

./get_resource.sh StructureDefinition /tmp/log
if [ $? != 0 ] ; then
 echo Failed to get $f
 exit 1
fi
