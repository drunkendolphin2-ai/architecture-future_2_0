# ---------- Доступ к облаку ----------

variable "service_account_key_file" {
  description = "Путь к авторизованному ключу сервисного аккаунта (JSON)"
  type        = string
  default     = "key.json"
}

variable "cloud_id" {
  description = "ID облака"
  type        = string
}

variable "folder_id" {
  description = "ID каталога"
  type        = string
}

variable "zone" {
  description = "Зона доступности"
  type        = string
  default     = "ru-central1-a"
}

variable "prefix" {
  description = "Префикс имён ресурсов"
  type        = string
  default     = "future2"
}

# ---------- Сеть ----------

variable "subnet_cidr" {
  description = "Подсеть"
  type        = string
  default     = "10.10.1.0/24"
}

variable "ssh_allowed_cidrs" {
  description = "Адреса, с которых разрешён SSH"
  type        = list(string)
}

# ---------- ВМ ----------

variable "image_family" {
  description = "Семейство образа ОС"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "platform_id" {
  description = "Платформа ВМ"
  type        = string
  default     = "standard-v3"
}

variable "preemptible" {
  description = "Прерываемая ВМ (дешевле, для учебного и тестового окружения)"
  type        = bool
  default     = true
}

variable "vm_cores" {
  type    = number
  default = 2
}

variable "vm_memory" {
  description = "ГБ"
  type        = number
  default     = 2
}

variable "vm_core_fraction" {
  description = "Гарантированная доля vCPU, %"
  type        = number
  default     = 20
}

# ---------- Диски ----------

variable "boot_disk_size" {
  description = "Размер загрузочного диска, ГБ"
  type        = number
  default     = 10
}

variable "data_disk_type" {
  type    = string
  default = "network-ssd"
}

variable "data_disk_size" {
  description = "ГБ"
  type        = number
  default     = 10
}

# ---------- SSH ----------

variable "ssh_user" {
  type    = string
  default = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Путь к публичному SSH-ключу"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}
