resource "google_dns_record_set" "service" {
  for_each     = var.services
  name         = "${each.value.name}.${data.google_dns_managed_zone.service.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.service.name
  rrdatas      = local.nat_ips
}

locals {
  network_interfaces = [for client in values(data.google_compute_instance.nomad_client) : one(client.network_interface)]
  access_configs     = [for iface in local.network_interfaces : iface.access_config]
  nat_ips            = [for access_config in local.access_configs : one(access_config).nat_ip]
}
