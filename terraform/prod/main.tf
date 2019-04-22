terraform {
  # Версия terraform
  required_version = ">0.11"
}

provider "google" {
  # Версия провайдера
  version = "2.0.0"

  # ID проекта
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["172.111.244.199/32"]
}

# resource "google_compute_instance" "app" {
#   name         = "reddit-app"
#   machine_type = "g1-small"
#   zone         = "${var.zone}"
#   tags         = ["reddit-app"]


#   # определение загрузочного диска


#   boot_disk {
#     initialize_params {
#       image = "${var.disk_image}"
#     }
#   }


#   # определение сетевого интерфейса


#   network_interface {
#     # сеть, к которой присоединить данный интерфейс
#     network = "default"


#     # использовать ephemeral IP для доступа из Интернет
#     access_config {
#         nat_ip = "${google_compute_address.app_ip.address}"
#     }
#   }
#   metadata {
#     # путь до публичного ключа
#     ssh-keys = "andrey:${file(var.public_key_path)} \nandrey1:${file(var.public_key_path)}"
#   }
#   connection {
#     type  = "ssh"
#     user  = "andrey"
#     agent = false


#     # путь до приватного ключа
#     private_key = "${file(var.private_key_path)}"
#   }
#   provisioner "file" {
#     source      = "files/puma.service"
#     destination = "/tmp/puma.service"
#   }
#   provisioner "remote-exec" {
#     script = "files/deploy.sh"
#   }
# }


# resource "google_compute_firewall" "firewall_puma" {
#   name = "allow-puma-default"


#   # Название сети, в которой действует правило
#   network = "default"


#   # Какой доступ разрешить
#   allow {
#     protocol = "tcp"
#     ports    = ["9292"]
#   }


#   # Каким адресам разрешаем доступ
#   source_ranges = ["0.0.0.0/0"]


#   # Правило применимо для инстансов с перечисленными тэгами
#   target_tags = ["reddit-app"]
# }


# resource "google_compute_firewall" "firewall_ssh" {
#   name        = "default-allow-ssh"
#   network     = "default"
#   description = "allow 22/ssh from 0.0.0.0/0"


#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }


#   source_ranges = ["0.0.0.0/0"]
# }


# resource "google_compute_address" "app_ip" {
#   name = "reddit-app-ip"
# }
