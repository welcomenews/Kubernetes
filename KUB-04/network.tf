# файл, в котором мы описываем настройки virtual private cloud. Мы создаем сеть
# internal, а также — по одной подсети в каждой зоне доступности — ru-central1-a,
# ru-central1-b и ru-central1-c:

resource "yandex_vpc_network" "internal" {
  name = "internal"
}

resource "yandex_vpc_subnet" "internal-a" {
  name           = "internal-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.internal.id
  v4_cidr_blocks = ["10.200.0.0/16"]
}

resource "yandex_vpc_subnet" "internal-b" {
  name           = "internal-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.internal.id
  v4_cidr_blocks = ["10.201.0.0/16"]
}

resource "yandex_vpc_subnet" "internal-c" {
  name           = "internal-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.internal.id
  v4_cidr_blocks = ["10.202.0.0/16"]
}