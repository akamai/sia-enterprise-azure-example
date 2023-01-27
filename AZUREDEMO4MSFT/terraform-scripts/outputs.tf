output "azure-firewall-ip" {
  value = module.network.firewall_ip.ip_address
}

output "windows-client-rdp-access" {
  value = "${module.network.firewall_ip.ip_address}:30001"
}

output "akamai-security-connector-access" {
  value = "${module.network.firewall_ip.ip_address}:30002"
}
