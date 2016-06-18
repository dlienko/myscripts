#!/bin/bash

for a in *.flac
do
    DATE=`metaflac "$a" --show-tag=DATE | sed s/.*=//g`
    DATE=$(( `echo $DATE | sed 's/[^0-9]//g'` % 100 ))

    ALBUM=`metaflac "$a" --show-tag=ALBUM | sed s/.*=//g`
    if [[ `echo $ALBUM | wc -w` -gt 1 ]]; then
        ABBR=""
        for word in $ALBUM; do
            ABBR=$ABBR"$(echo $word | head -c 1)"
        done
        ABBR=`echo $ABBR | tr [:lower:] [:upper:]`
    else
        ABBR=`echo $ALBUM | head -c 3`
    fi
	
	TITLE=`metaflac "$a" --show-tag=TITLE | sed s/.*=//g`
	
	TRACKNUMBER=`metaflac "$a" --show-tag=TRACKNUMBER | sed s/.*=//g`
	
	mv "$a" "`printf %02g $DATE` $ABBR - `printf %02g $TRACKNUMBER` $TITLE.flac"
done
