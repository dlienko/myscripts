#!/bin/bash

# sudo apt-get install cuetools shntool flac

FLAC=`grep FILE "$1" | grep WAVE | awk '{$1=""; $NF=""; sub(" ", ""); print}' | cut -d \" -f 2`
echo $FLAC

cuebreakpoints "$1" | shnsplit -o flac "$FLAC"

echo Setting tags...
cuetag "$1" split-track*.flac

echo Renaming tracks...
for a in split-track*.flac; do
	TITLE=`metaflac "$a" --show-tag=TITLE | sed s/.*=//g`
	TRACKNUMBER=`metaflac "$a" --show-tag=TRACKNUMBER | sed s/.*=//g`
	mv "$a" "`printf %02g $TRACKNUMBER` - $TITLE.flac"
done

echo Removing original cue and flac files...
mv "$1" "$FLAC" /media/dimbas/hdd/trash/
