resource "random_id" "azurerm" {
  byte_length = 2
}

resource "azurerm_storage_account" "la_storage" {
  name                     = "laterraform${random_id.azurerm.hex}"
  resource_group_name      = "${azurerm_resource_group.terraform_rg.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags {
    group = "LinuxAcademy"
  }
}

resource "azurerm_storage_container" "la_cont" {
  name                  = "vhds"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  storage_account_name  = "${azurerm_storage_account.la_storage.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "la_cont_script" {
  name                  = "scripts"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  storage_account_name  = "${azurerm_storage_account.la_storage.name}"
  container_access_type = "blob"
}

data "template_file" "apache_php_sh" {
  template = "${file("../scripts/apache_php.sh.tmpl")}"

  vars {
    AZURE_STORAGE_ACCOUNT_NAME = "${azurerm_storage_account.la_storage.name}"
    CONTAINER_NAME             = "${azurerm_storage_container.la_cont_script.name}"
  }
}

resource "local_file" "local_apache_php" {
  content = <<EOF
${data.template_file.apache_php_sh.rendered}
EOF
  filename = "apache_php.sh"
}

data "template_file" "mysql_install_sh" {
  template = "${file("../scripts/mysql_install.sh.tmpl")}"
}

resource "local_file" "local_mysql_install" {
  content = <<EOF
${data.template_file.mysql_install_sh.rendered}
EOF
  filename = "mysql_install.sh"
}

resource "azurerm_storage_blob" "apache_php_sh" {
  depends_on             = ["azurerm_storage_container.la_cont_script"]
  name                   = "apache_php.sh"
  resource_group_name    = "${azurerm_resource_group.terraform_rg.name}"
  storage_account_name   = "${azurerm_storage_account.la_storage.name}"
  storage_container_name = "${azurerm_storage_container.la_cont_script.name}"
  type                   = "block"
  source                 = "apache_php.sh"
}

resource "azurerm_storage_blob" "demo_php" {
  depends_on             = ["azurerm_storage_container.la_cont_script"]
  name                   = "demo.php"
  resource_group_name    = "${azurerm_resource_group.terraform_rg.name}"
  storage_account_name   = "${azurerm_storage_account.la_storage.name}"
  storage_container_name = "${azurerm_storage_container.la_cont_script.name}"
  type                   = "block"
  source                 = "../scripts/demo.php"
}

resource "azurerm_storage_blob" "mysql_install_sh" {
  depends_on             = ["azurerm_storage_container.la_cont_script"]
  name                   = "mysql_install.sh"
  resource_group_name    = "${azurerm_resource_group.terraform_rg.name}"
  storage_account_name   = "${azurerm_storage_account.la_storage.name}"
  storage_container_name = "${azurerm_storage_container.la_cont_script.name}"
  type                   = "block"
  source                 = "mysql_install.sh"
}
