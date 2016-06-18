#!/bin/bash

# renames the flac files as I prefer :)

for a in *.flac; do
	TITLE=`metaflac "$a" --show-tag=TITLE | sed s/.*=//g`
	TRACKNUMBER=`metaflac "$a" --show-tag=TRACKNUMBER | sed s/.*=//g`
	mv "$a" "`printf %02g $TRACKNUMBER` - $TITLE.flac"
done
