#!/bin/bash

###############################################################
#  AUTEUR:   Xavier
#
#  DESCRIPTION:  création d'un user spécific pour docker
###############################################################


groupadd -g 500000 dockremap &&
groupadd -g 501000 dockremap-user &&
useradd -u 500000 -g dockremap -s /bin/false dockremap &&
useradd -u 501000 -g dockremap-user -s /bin/false dockremap-user

echo "dockremap:500000:65536" >> /etc/subuid &&
echo "dockremap:500000:65536" >>/etc/subgid

echo "
  {
   \"userns-remap\": \"default\"
  }
" > /etc/docker/daemon.json

systemctl daemon-reload && systemctl restart docker

#Source: https://youtu.be/W6p_aiYplbM
