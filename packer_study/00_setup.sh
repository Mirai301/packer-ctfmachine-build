#!/bin/bash

set -eu

cat <<'EOF' >/etc/netplan/99-manual.yaml
network:
    version: 2
    ethernets:
        ens2:
            dhcp4: true
EOF
