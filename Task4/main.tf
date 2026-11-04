terraform {
  required_version = ">= 1.5"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.130"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

# ---------- Сеть ----------

resource "yandex_vpc_network" "main" {
  name = "${var.prefix}-network"
}

resource "yandex_vpc_subnet" "main" {
  name           = "${var.prefix}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.subnet_cidr]
}

resource "yandex_vpc_security_group" "vm" {
  name       = "${var.prefix}-vm-sg"
  network_id = yandex_vpc_network.main.id

  ingress {
    description    = "SSH только с разрешённых адресов"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = var.ssh_allowed_cidrs
  }

  egress {
    description    = "Исходящий трафик"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# ---------- Диски ----------

resource "yandex_compute_disk" "boot" {
  name     = "${var.prefix}-boot"
  zone     = var.zone
  type     = "network-hdd"
  image_id = data.yandex_compute_image.ubuntu.image_id
  size     = var.boot_disk_size
}

resource "yandex_compute_disk" "data" {
  name = "${var.prefix}-data"
  zone = var.zone
  type = var.data_disk_type
  size = var.data_disk_size
}

# ---------- Виртуальная машина ----------

resource "yandex_compute_instance" "vm" {
  name        = "${var.prefix}-vm"
  hostname    = "${var.prefix}-vm"
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot.id
  }

  secondary_disk {
    disk_id     = yandex_compute_disk.data.id
    device_name = "data"
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.main.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.vm.id]
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }
}
