resource "azurerm_dns_zone" "la_dns" {
  name = "yourdomain.com"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
}

resource "azurerm_dns_a_record" "la_a" {
  name = "LA-A_Record"
  zone_name = "${azurerm_dns_zone.la_dns.name}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  ttl = 300
  records = ["${azurerm_public_ip.la_pip.id}"]
}
