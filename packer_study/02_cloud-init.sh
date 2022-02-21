#!/bin/bash

set -eu

export PUBLIC_KEY="!!!!! PUBLIC KEY !!!!!"

mkdir -p /etc/cloud

cat >/etc/cloud/cloud.cfg <<EOF
users:
   - default

disable_root: true
ssh_pwauth:   true

preserve_hostname: false
manage_etc_hosts: false

apt_preserve_sources_list: true
apt_update: false
apt_upgrade: false
apt_reboot_if_required: false

cloud_init_modules:
 - migrator
 - seed_random
 - bootcmd
 - write-files
 - growpart
 - resizefs
 - disk_setup
 - mounts
 - set_hostname
 - update_etc_hosts
 - rsyslog
 - users-groups
 - ssh

cloud_config_modules:
 - emit_upstart
 - snap
 - ssh-import-id
 - locale
 - set-passwords
 - grub-dpkg
 - apt-pipelining
 - apt-configure
 - ubuntu-advantage
 - ntp
 - timezone
 - disable-ec2-metadata
 - runcmd
 - byobu

cloud_final_modules:
 - package-update-upgrade-install
 - fan
 - landscape
 - lxd
 - puppet
 - chef
 - mcollective
 - salt-minion
 - rightscale_userdata
 - scripts-vendor
 - scripts-per-once
 - scripts-per-boot
 - scripts-per-instance
 - scripts-user
 - ssh-authkey-fingerprints
 - keys-to-console
 - phone-home
 - final-message
 - power-state-change

system_info:
   distro: ubuntu
   default_user:
     name: ubuntu
     lock_passwd: True
     ssh_authorized_keys:
       - ${PUBLIC_KEY}
     gecos: Ubuntu
     groups: [adm, audio, cdrom, dialout, dip, floppy, lxd, netdev, plugdev, sudo, video]
     sudo: ["ALL=(ALL) NOPASSWD:ALL"]
     shell: /bin/bash
   ntp_client: auto
   paths:
      cloud_dir: /var/lib/cloud/
      templates_dir: /etc/cloud/templates/
      upstart_dir: /etc/init/
   ssh_svcname: ssh
EOF

systemctl enable cloud-init
