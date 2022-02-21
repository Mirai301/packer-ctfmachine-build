#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive

apt -oApt::Cmd::Disable-Script-Warning=1 -y clean
cloud-init clean

usermod -L ubuntu
rm -f /etc/sudoers.d/90-cloud-init-users
rm -rf /home/ubuntu

rm -rf /tmp/*
rm -f /var/run/utmp
find /var/log/ -type f -print0 | xargs -0 rm -f
touch /var/log/lastlog

set +e

dd if=/dev/zero of=/EMPTY bs=1M
while [ -f /EMPTY ]; do
  rm -fv /EMPTY
  sleep 1
done
