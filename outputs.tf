output "f5vm_ip" {
    value = [
        for vm in module.f5vm[*].bigip:{
            zone = vm.zone
            name = vm.name

            ext_ip = vm.network_interface.0.network_ip
            ext_public_ip = vm.network_interface.0.access_config.0.nat_ip
            mgmt_ip = vm.network_interface.1.network_ip
            mgmt_public_ip = vm.network_interface.1.access_config.0.nat_ip
        }
    ]
}

resource "local_file" "DO" {
    count = length(module.f5vm[*])
    content = templatefile("${path.module}/pp-do-template.json",
        {
            hostname           = "${var.host_name}-${count.index}",
            dns_server         = "8.8.8.8",
            dns_suffix         = "c.f5-gcs-4261-sales-na-w.internal",
            ntp_server         = "0.us.pool.ntp.org",
            timezone           = "UTC",
            admin_username     = var.uname,
            admin_password     = var.admin_password,
            local_selfip_int   = module.f5vm != [] ? module.f5vm[count.index].bigip.network_interface.2.network_ip : null
            sync_group_members = module.f5vm != [] ? join(",",[
                for bigip in module.f5vm[*].bigip:
                    "\"${bigip.network_interface.2.network_ip}\""
            ]) : ""
        }
    )
    filename = "${path.module}/do-${module.f5vm[count.index].bigip.name}.json"
}