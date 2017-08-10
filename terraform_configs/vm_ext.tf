resource "azurerm_virtual_machine_extension" "cs_apache" {
  name 					= "custom_apache"
  location 				= "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  virtual_machine_name 	= "${azurerm_virtual_machine.la_web.name}"
  publisher 			= "Microsoft.OSTCExtensions"
  type 					= "CustomScriptForLinux"
  type_handler_version 	= "1.2"
  
  settings = <<SETTINGS
  {
	"fileUris": [
	"LINK-TO-FILE"
	],
	"commandToExecute": "sh "
  }
SETTINGS
  
  tags {
	group = "LinuxAcademy"
  }
}

resource "azurerm_virtual_machine_extension" "cs_mysql" {
  name 					= "custom_mysql"
  location 				= "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  virtual_machine_name 	= "${azurerm_virtual_machine.la_db.name}"
  publisher 			= "Microsoft.OSTCExtensions"
  type 					= "CustomScriptForLinux"
  type_handler_version 	= "1.2"
  
  settings = <<SETTINGS
  {
	"fileUris": [
	"LINK-TO-FILE"
	],
	"commandToExecute": "sh "
  }
SETTINGS
  
  tags {
	group = "LinuxAcademy"
  }
}