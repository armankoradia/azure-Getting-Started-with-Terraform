resource "azurerm_storage_account" "la_storage" {
  name 					= "laterraform1"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
  location 				= "${var.location}"
  account_type 			= "Standard_LRS"
  
  tags {
	group = "LinuxAcademy"
  }
}

resource "azurerm_storage_container" "la_cont" {
  name 					= "vhds"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
  storage_account_name 	= "${azurerm_storage_account.la_storage.name}"
  container_access_type = "private"
}