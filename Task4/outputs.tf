output "network_id" {
  value = yandex_vpc_network.main.id
}

output "vm_public_ip" {
  value = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}

output "vm_private_ip" {
  value = yandex_compute_instance.vm.network_interface[0].ip_address
}

output "data_disk_id" {
  value = yandex_compute_disk.data.id
}

output "ssh_command" {
  value = "ssh ${var.ssh_user}@${yandex_compute_instance.vm.network_interface[0].nat_ip_address}"
}
