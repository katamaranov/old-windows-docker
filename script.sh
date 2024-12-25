#!/bin/bash
WINARG="$1"
echo "$WINARG" > /prjct/ENVF
FILENAME="$WINARG.7z"
URL="https://github.com/katamaranov/windows-images/raw/refs/heads/main/$FILENAME"
declare -A win_dirs
win_dirs=( 
    [win1]="/opt/win1"
    [win2]="/opt/win2"
    [win3]="/opt/win3"
)
num=$(echo "$WINARG" | grep -o '[0-9]+')
target_dir="${win_dirs[$WINARG]}"

    if [ -z "$(ls -A $target_dir)" ]; then
        
        wget -O "$FILENAME" "$URL"
        7z e -y "$FILENAME" -o"$target_dir"
        chmod +x "$target_dir"
        if ps aux | grep -w "supervisord" > /dev/null; then
            pkill -f /usr/bin/supervisord	    
            sleep 1
            /usr/bin/supervisord -c "/etc/supervisord-$num.conf"
    	else
             /usr/bin/supervisord -c "/etc/supervisord-$num.conf"
        fi
        
    else
        if ps aux | grep -w "supervisord" > /dev/null; then
            pkill -f /usr/bin/supervisord 
   	    sleep 1
             /usr/bin/supervisord -c "/etc/supervisord-$num.conf"

        else
             /usr/bin/supervisord -c "/etc/supervisord-$num.conf"
        fi
    fi
