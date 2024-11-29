#!/bin/bash

ARG=$(cat /prjct/ENVF)

if [[ "$ARG" == "win2" ]]; then
    qemu-system-i386 -hda /opt/win2/disk.img -vnc :0 -boot c -m 256
elif [[ "$ARG" == "win1" ]]; then
    qemu-system-i386 -hda /opt/win1/disk.img -fda /opt/win1/Dos.img -qmp tcp:localhost:4444,server,nowait -vnc :0 -boot a -m 32
elif [[ "$ARG" == "win3" ]]; then
    qemu-system-i386 -hda /opt/win3/disk.img -vnc :0 -boot c -m 566
fi