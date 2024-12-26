provider "proxmox" {
    pm_api_url = "https://your-proxmox-server:8006/api2/json"
    pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "nixos-services-vm" {
    name        = "nixos-services-vm"
    target_node = "pve"
    clone       = "template-name"
    os_type     = "cloud-init"
    cores       = 2
    memory      = 2048
    disk {
        size = "10G"
    }
    network {
        model  = "virtio"
        bridge = "vmbr0"
    }
    sshkeys = file("~/.ssh/id_rsa.pub")
    ipconfig0 = "ip=dhcp"
    cloud_init {
        user_data = <<EOF
#cloud-config
users:
    - name: nixos
        ssh-authorized-keys:
            - ${file("~/.ssh/id_rsa.pub")}
EOF
    }
}

output "nixos_vm_ip" {
    value = proxmox_vm_qemu.nixos_vm.network.0.ip
}