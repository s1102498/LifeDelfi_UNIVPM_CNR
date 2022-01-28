#!/bin/bash

# Check audio card
audiocard=$(arecord -l)
expected="ALC295" # change with your audiocard
[[ $audiocard =~ (^|[[:space:]])$expected($|[[:space:]]) ]] && echo "Using $expected audio input" || return

# Check USB device
homedir="/media"
usbdevices=$(ls $homedir)

if [ ${#usbdevices[@]} -eq 0 ]; then
    echo "No USB devices detected"
    return
fi

echo "Using $homedir/${usbdevices[0]} as storage"

# Get counter of acquisition
usbdir="$homedir/$usbdevices"

COUNTER=$(ls -l $usbdir | grep -c ^d)
echo "Found $COUNTER folders"
echo "Creating folder: $COUNTER"
mkdir $usbdir/$COUNTER

# Start recording
CHANNELS=1
FREQUENCY=192000
SAVEDIR="$usbdir/$COUNTER"
STIME=10
FILETYPE=wav

arecord --duration=$STIME --channels=$CHANNELS --file-type $FILETYPE --rate=$FREQUENCY $SAVEDIR/acq.wav


