#!/bin/bash

# build / update image 
#docker build --rm -t kali:core -f Dockerfile .

# start kali  
xhost + &&\
docker run --rm -ti                                     \
    --hostname kalilinux                                \
    --name kali                                         \
    --cap-add=NET_ADMIN                                 \
    --device /dev/net/tun                               \
    --sysctl net.ipv6.conf.all.disable_ipv6=0           \
    --network bridge                                      \
    -v "$PWD:/home/kali"                    \
    -e DISPLAY=:0 -v /tmp/.X11-unix:/tmp/.X11-unix      \
    kali:core bash &&\
xhost -




