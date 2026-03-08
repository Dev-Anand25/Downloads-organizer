#!/bin/bash

DOWNLOADS="$(xdg-user-dir DOWNLOAD)"
PICTURES="$(xdg-user-dir PICTURES)"
VIDEOS="$(xdg-user-dir VIDEOS)"
MUSIC="$(xdg-user-dir MUSIC)"
DOCUMENTS="$(xdg-user-dir DOCUMENTS)"

organize_file() {

FILE="$1"
FILEPATH="$DOWNLOADS/$FILE"

[[ ! -f "$FILEPATH" || "$FILE" == .* ]] && return

EXT="${FILE##*.}"
EXT=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')

case "$EXT" in

# Images
jpg|jpeg|png|gif|webp|svg|bmp)
DEST="$PICTURES"
;;

# Videos
mp4|mkv|avi|mov|webm)
DEST="$VIDEOS"
;;

# Audio
mp3|wav|flac|aac|ogg)
DEST="$MUSIC"
;;

# Documents
pdf|doc|docx|ppt|pptx|xls|xlsx|txt)
DEST="$DOCUMENTS"
;;

# Archives
zip|tar|gz|rar|7z)
DEST="$DOCUMENTS/Archives"
mkdir -p "$DEST"
;;

# Code
py|java|c|cpp|js|ts|html|css|json|sh)
DEST="$DOCUMENTS/Code"
mkdir -p "$DEST"
;;

# Others
*)
DEST="$DOCUMENTS/Others"
mkdir -p "$DEST"
;;

esac

TARGET="$DEST/$FILE"

COUNT=1
while [ -f "$TARGET" ]; do
NAME="${FILE%.*}"
EXT="${FILE##*.}"
TARGET="$DEST/${NAME}_$COUNT.$EXT"
((COUNT++))
done

mv "$FILEPATH" "$TARGET"
}

for FILE in "$DOWNLOADS"/*; do
FILE=$(basename "$FILE")
organize_file "$FILE"
done
