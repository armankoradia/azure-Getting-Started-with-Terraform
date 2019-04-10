output "LA-Terraform-WebVM-IP" {
  value = "${azurerm_public_ip.la_pip.ip_address}"
}