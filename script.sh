#!/bin/bash

extract_archive() {
    local archive="$1"
    if [[ -f "$archive" ]]; then
        echo "Распаковка $archive"
        tar -xzf "$archive" -C "$(dirname "$archive")" >/dev/null 2>&1
    else
	echo "$archive не найден"
    fi
}

initial_archive=$(find / -name "archive.tar.gz" 2>/dev/null)
if [[ -z "$initial_archive" ]]; then
    echo "Архив archive.tar.gz не найден"
    exit 1
fi

extract_archive "$initial_archive"

while true; do
    archive=$(find . -name "archive-*.tar.gz" | head -n 1)
    if [[ -z "$archive" ]]; then
	echo "Все вложенные архивы извлечены."
    	break
    fi
    if [[ -f "$archive" ]]; then
	extract_archive "$archive"
        rm "$archive"
    fi
done
