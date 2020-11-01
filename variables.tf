variable regions { type=list }
variable bigip_per_region { default = 1 }
variable zones {}
variable host_name {}
variable tags { 
    type=list 
    default = []
}
variable uname { default = "admin"}
variable usecret {}
variable ksecret {}
variable admin_password {}
variable ssh_public_key {}
variable license1 { default = "" }
variable mgmt_src_addr {}
variable dns_server { default = "8.8.8.8" }
variable dns_suffix {}
variable ntp_server { default = "0.us.pool.ntp.org" }
variable timezone { default = "UTC" }
variable DO_URL { default = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.14.0/f5-declarative-onboarding-1.14.0-1.noarch.rpm" }
variable AS3_URL { default = "https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.21.0/f5-appsvcs-3.21.0-4.noarch.rpm" }
variable TS_URL { default = "https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.13.0/f5-telemetry-1.13.0-2.noarch.rpm" }
variable onboard_log { default = "/var/log/cloud/onboard.log" }


# BIGIP Image
variable bigipMachineType { default = "n1-standard-8" }
variable image_name { default = "projects/f5-7626-networks-public/global/images/f5-bigip-15-1-0-4-0-0-6-payg-best-1gbps-200618231635" }
variable customImage { default = "" }
variable customUserData { default = "" }


# NETWORK
variable ext_vpc {}
variable ext_subnet {}
# variable ext_alias_ip_cidr{}
variable int_vpc {}
variable int_subnet {}
variable mgmt_vpc {}
variable mgmt_subnet {}

variable gcp_project_id {}
variable svc_acct {}