#!/bin/bash

# This script runs the FDS Verification Cases on a linux machine with
# a batch queuing system

export SVNROOT=`pwd`/..
export FDS=$SVNROOT/FDS_Compilation/intel_linux_64/fds_intel_linux_64
export FDSMPI=$SVNROOT/FDS_Compilation/mpi_intel_linux_64/fds_mpi_intel_linux_64

# VVVVVVVVVVVVVVVVV select which group of nodes to run on VVVVVVVV

# new cluster
export RUNFDS=$SVNROOT/Utilities/Scripts/runfds.sh
export RUNFDSMPI=$SVNROOT/Utilities/Scripts/runfdsmpi.sh

# fire70s
#export RUNFDS=$SVNROOT/Utilities/Scripts/runfds7.sh
#export RUNFDSMPI=$SVNROOT/Utilities/Scripts/runfdsmpi7.sh

# firevis/smokevis
#export RUNFDS=$SVNROOT/Utilities/Scripts/runfdsv.sh
#export RUNFDSMPI=$SVNROOT/Utilities/Scripts/runfdsmpiv.sh

# ^^^^^^^^^^^^^^^^^ select nodes to run on ^^^^^^^^^^^^^^^^^^^^^^

export BASEDIR=`pwd`

# uncomment following line to stop all cases
# export STOPFDS=1

./FDS_Cases.sh
./FDS_MPI_Cases.sh

echo FDS cases submitted

