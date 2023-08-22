resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnetname
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnetaddressspace]
}

resource "azurerm_subnet" "vmsubnet" {
  name                 = "vmsubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "pesubnet" {
  name                 = "pesubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet3" {
  name                 = "subnet3"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "subnet4" {
  name                 = "subnet4"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "vmnsg" {
  name                = "vmnsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "myoutboundnsgrule" {
  name                        = "VMtoStorage"
  priority                    = 1000
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = azurerm_subnet.vmsubnet.address_prefixes[0]
  destination_address_prefix  = azurerm_subnet.pesubnet.address_prefixes[0]
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vmnsg.name
}

resource "azurerm_network_security_rule" "myinboundnsgrule" {
  name                        = "StoragetoVM"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = azurerm_subnet.pesubnet.address_prefixes[0]
  destination_address_prefix  = azurerm_subnet.vmsubnet.address_prefixes[0]
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vmnsg.name
}

resource "azurerm_network_security_rule" "vmconnect" {
  name                        = "ConnectToVM"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vmnsg.name
}

resource "azurerm_network_security_rule" "connectvm" {
  name                        = "VMConnect"
  priority                    = 1003
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vmnsg.name
}