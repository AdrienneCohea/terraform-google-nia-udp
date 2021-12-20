data "google_compute_instance" "nomad_client" {
  for_each = var.services
  name     = each.value.node
}

data "google_dns_managed_zone" "service" {
  name = var.managed_zone
}
