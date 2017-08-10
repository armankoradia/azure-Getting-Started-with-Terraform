resource "azurerm_public_ip" "la_pip" {
  name 							= "LA-Terraform-PIP"
  location 						= "${var.location}"
  resource_group_name 			= "${azurerm_resource_group.terraform_rg.name}"
  public_ip_address_allocation 	= "dynamic"
  
  tags {
	group = "LinuxAcademy"
  }
}

resource "azurerm_network_interface" "public_nic" {
  name 					= "LA-Terraform-Web"
  location 				= "${var.location}"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
  
  ip_configuration {
    name 							= "LA-Terraform-WebPrivate"
    subnet_id 					= "${azurerm_subnet.la_subnet_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id 			= "${azurerm_public_ip.la_pip.id}"
  }
  tags {
	group = "LinuxAcademy"
  }
}

resource "azurerm_network_interface" "private_nic" {
  name 					= "LA-Terraform-DB"
  location 				= "${var.location}"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
  
  ip_configuration {
    name 							= "LA-Terraform-DBPrivate"
    subnet_id 					= "${azurerm_subnet.la_subnet_2.id}"
    private_ip_address_allocation = "static"
  }
  tags {
	group = "LinuxAcademy"
  }
}