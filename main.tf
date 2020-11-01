# BIG-IP


data "google_compute_subnetwork" "ext" {
  count = length(var.regions)
  self_link = var.ext_subnet[count.index]
}

module "f5vm" {
  count             = var.bigip_per_region * length(var.regions)
  source            = "github.com/mjmenger/terraform-gcp-bigip"
  host_name         = format("%s-%s-%02d","cl",var.host_name,count.index)
  zone              = var.zones[count.index % length(var.regions)].names[floor(count.index / length(var.regions))]
  uname             = var.uname
  usecret           = var.usecret
  ksecret           = var.ksecret
  ssh_public_key    = var.ssh_public_key
  adminSrcAddr      = var.mgmt_src_addr
  ext_vpc           = var.ext_vpc
  ext_subnet        = var.ext_subnet[count.index % length(var.regions)]
  ext_alias_ip_cidr = cidrsubnet(data.google_compute_subnetwork.ext[count.index % length(var.regions)].ip_cidr_range,8,100 + count.index)
  int_vpc           = var.int_vpc
  int_subnet        = var.int_subnet[count.index % length(var.regions)]
  mgmt_vpc          = var.mgmt_vpc
  mgmt_subnet       = var.mgmt_subnet[count.index % length(var.regions)]
  dns_suffix        = var.dns_suffix
  gcp_project_id    = var.gcp_project_id
  svc_acct          = var.svc_acct
}


