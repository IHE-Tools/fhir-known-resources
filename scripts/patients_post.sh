#!/bin/sh

check_args() {
 if [ $# != 1 ] ; then
  echo "Arguments: folder"
  echo "           folder contains one or more xml Patient resources"
  exit 1
 fi

 if [ ! -e $1 ] ; then
  echo "The folder $1 does not exist; exiting"
  exit 1
 fi
}

check_args $*

touch  ../tmp ../logs
rm -rf ../tmp ../logs
mkdir  ../tmp ../logs

for f in $1/*xml; do
 last_token=`./last_path_component.sh $f`
 echo $f $last_token
 ./post_resource.sh Patient $f ../logs/$last_token.txt
 if [ $? != 0 ] ; then
  echo Failed to post $f
  exit 1
 fi
done
