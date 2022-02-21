#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive

apt -oApt::Cmd::Disable-Script-Warning=1 -y clean
apt -oApt::Cmd::Disable-Script-Warning=1 -y update

apt -oApt::Cmd::Disable-Script-Warning=1 -y install nginx

systemctl enable nginx
