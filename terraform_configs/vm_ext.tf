resource "azurerm_virtual_machine_extension" "cs_apache" {
  name                 = "custom_apache"
  location             = "${var.location}"
  resource_group_name  = "${azurerm_resource_group.terraform_rg.name}"
  virtual_machine_name = "${azurerm_virtual_machine.la_web.name}"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
  "script": "${base64encode(data.template_file.apache_php_sh.rendered)}"
  }
SETTINGS

  tags {
    group = "LinuxAcademy"
  }
}

resource "azurerm_virtual_machine_extension" "cs_mysql" {
  name                 = "custom_mysql"
  location             = "${var.location}"
  resource_group_name  = "${azurerm_resource_group.terraform_rg.name}"
  virtual_machine_name = "${azurerm_virtual_machine.la_db.name}"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
  "script": "${base64encode(data.template_file.mysql_install_sh.rendered)}"
  }
SETTINGS

  tags {
    group = "LinuxAcademy"
  }
}
