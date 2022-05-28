#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt -oApt::Cmd::Disable-Script-Warning=1 -y install nmap