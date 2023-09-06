output "resource_group_name" {
  value = var.resource_group_name
}

output "vnetname" {
  value = var.vnetname
}

output "vnetid" {
    value = azurerm_virtual_network.vnet1.id
}

output "vmsubnet" {
  value = azurerm_subnet.vmsubnet.name
}

output "vmsubnetid" {
    value = azurerm_subnet.vmsubnet.id
}

output "pesubnetid" {
    value = azurerm_subnet.pesubnet.id
}

output "subnet3" {
  value = azurerm_subnet.subnet3.name
}

output "subnet3id" {
    value = azurerm_subnet.subnet3.id
}

output "subnet4" {
  value = azurerm_subnet.subnet4.name
}

output "subnet4id" {
    value = azurerm_subnet.subnet4.id
}

output "vmsubnet_address_prefix" {
  value = azurerm_subnet.vmsubnet.address_prefixes
}

output "pesubnet_address_prefix" {
  value = azurerm_subnet.pesubnet.address_prefixes
}

output "nsgid" {
  value = azurerm_network_security_group.vmnsg.id
}