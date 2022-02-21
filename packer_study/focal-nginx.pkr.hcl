source "qemu" "focal_nginx" {
  accelerator = "kvm"

  iso_checksum     = "md5:671fe3a2e40efd4b2a4d011c93714697"
  iso_url          = "focal-server-cloudimg-amd64.img"
  disk_compression = true
  disk_image       = true
  disk_size        = 5000
  format           = "qcow2"
  output_directory = "output"
  vm_name = format(
    "focal-server-nginx-amd64-%s.qcow2",
    formatdate("YYYY-MM-DD-hh-mm", timestamp()),
  )

  ssh_username     = "ubuntu"
  ssh_password     = "password"
  ssh_port         = 22
  ssh_wait_timeout = "300s"

  headless            = true
  use_default_display = true

  qemuargs = [
    ["-m", "2048M"],
    ["-smp", "2"],
    ["-fda", "cloud.img"],
    ["-serial", "mon:stdio"],
  ]
}

build {
  sources = ["source.qemu.focal_nginx"]

  provisioner "shell" {
    execute_command = "sudo -S sh '{{ .Path }}'"
    scripts = [
      "00_setup.sh",
      "01_nginx.sh",
      "02_cloud-init.sh",
      "99_cleanup.sh",
    ]
  }
}
