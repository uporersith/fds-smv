#!/bin/bash

# This script generates smokeview pictures from the
# FDS Verification Cases on a Linux or OS X machine

function usage {
echo "Make_FDS_Pictures.sh [-d -h -r -s size -X ]"
echo "Generates Smokeview figures from FDS verification suite"
echo ""
echo "Options"
echo "-d - use debug version of smokeview"
echo "-h - display this message"
echo "-p path - specify path of the smokeview executable"
echo "-r - use release version of smokeview"
echo "-s size - use 32 or 64 bit (default) version of smokeview"
echo "-S host - make pictures on host"
echo "-t - use test version of smokeview"
echo "-X - do not start / stop separate X-server"
exit
}

prog=$0
progname=${prog##*/}
CURDIR=`pwd`
OS=`uname`
if [ "$OS" == "Darwin" ]; then
  PLATFORM=osx
else
  PLATFORM=linux
fi

SIZE=_64
DEBUG=
TEST=
SMV_PATH=""
START_X=yes
SSH=

while getopts 'dhp:rs:S:tX' OPTION
do
case $OPTION  in
  d)
   DEBUG=_db
   ;;
  h)
   usage;
   ;;
  p)
   SMV_PATH="$OPTARG"
   ;;
  r)
   TEST=
  ;;
  s)
   SIZE="$OPTARG"
   if [ $SIZE -eq 64 ] ; then
     SIZE=_64
   else
     SIZE=_32
   fi
  ;;
  S)
   SSH="ssh $OPTARG"
   ;;
  t)
   TEST=_test
  ;;
  X)
   START_X=no
  ;;
esac
done
shift $(($OPTIND-1))

export SVNROOT=`pwd`/../..
if [ "$SMV_PATH" == "" ]; then
  SMV_PATH=$SVNROOT/SMV/Build/smokeview/intel_$PLATFORM$SIZE
fi
export SMV=$SMV_PATH/smokeview_$PLATFORM$TEST$SIZE$DEBUG
export RUNSMV=$SVNROOT/FDS/Utilities/Scripts/runsmv.sh
export SMVBINDIR="-bindir $SVNROOT/SMV/for_bundle/"
export BASEDIR=`pwd`/..

echo "erasing SCRIPT_FIGURES png files"
rm -f $SVNROOT/FDS/Manuals/FDS_Configuration_Management_Plan/SCRIPT_FIGURES/*.png
rm -f $SVNROOT/FDS/Manuals/FDS_Technical_Reference_Guide/SCRIPT_FIGURES/*.png
rm -f $SVNROOT/FDS/Manuals/FDS_User_Guide/SCRIPT_FIGURES/*.png
rm -f $SVNROOT/FDS/Manuals/FDS_Validation_Guide/SCRIPT_FIGURES/*.png
rm -f $SVNROOT/FDS/Manuals/FDS_Verification_Guide/SCRIPT_FIGURES/*.png

if [ "$START_X" == "yes" ]; then
  source $SVNROOT/FDS/Utilities/Scripts/startXserver.sh 2>/dev/null
fi
cd $SVNROOT/FDS/Verification
./FDS_Pictures.sh
if [ "$START_X" == "yes" ]; then
  source $SVNROOT/FDS/Utilities/Scripts/stopXserver.sh 2>/dev/null
fi
cd $CURDIR
echo $progname complete
