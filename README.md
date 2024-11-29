# old-windows-docker

This is a docker image with a DOS virtual machine where old versions of windows (1.02, 2.03, 3.1) are installed. 

# Usage

You can access these virtual machines through a browser. go to _localhost:8888_, this is a launcher where you can install Windows files (they do not come with the image, but because these are very old systems, these files weigh a couple of megabytes) and switch between three Windows. In the future, the ability will be added through the launcher to upload files to a virtual machine, and download files from there (although most likely this makes sense only for windows 3.1, I don't know who needs files from windows 1.0 ...)

# Installation

To install, just write ```docker run -d -p 8888:8888 -p 5335:5335 nekkoarcc/oldwindows```
