# Akamai SIA Cloud Security Connector<!-- omit in toc -->

Demo prepared for Microsoft
January 2023

## Table of contents<!-- omit in toc -->

- [Must read before starting](#must-read-before-starting)
- [Deploying the demo](#deploying-the-demo)
- [Appendixes](#appendixes)
  - [Windows 11 Pro gotcha](#windows-11-pro-gotcha)
    - [Template](#template)
    - [Variable](#variable)

## Must read before starting

Read the general [Azure/Security Connector](../AZURE/README.md) instructions.

## Deploying the demo

```bash
# Customize to you own
MYTFVAR="../variable-files/androcho-jan23-demo.tf"

terraform init
terraform plan -var-file=$MYTFVAR
terraform apply -var-file=$MYTFVAR

# And once the demo is over
terraform destroy -var-file=$MYTFVAR
```
## Appendixes

### Windows 11 Pro gotcha

#### Template

```json
{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "location": {
            "type": "string"
        },
        "networkInterfaceName": {
            "type": "string"
        },
        "enableAcceleratedNetworking": {
            "type": "bool"
        },
        "networkSecurityGroupName": {
            "type": "string"
        },
        "networkSecurityGroupRules": {
            "type": "array"
        },
        "subnetName": {
            "type": "string"
        },
        "virtualNetworkId": {
            "type": "string"
        },
        "publicIpAddressName": {
            "type": "string"
        },
        "publicIpAddressType": {
            "type": "string"
        },
        "publicIpAddressSku": {
            "type": "string"
        },
        "pipDeleteOption": {
            "type": "string"
        },
        "virtualMachineName": {
            "type": "string"
        },
        "virtualMachineComputerName": {
            "type": "string"
        },
        "virtualMachineRG": {
            "type": "string"
        },
        "osDiskType": {
            "type": "string"
        },
        "osDiskDeleteOption": {
            "type": "string"
        },
        "virtualMachineSize": {
            "type": "string"
        },
        "nicDeleteOption": {
            "type": "string"
        },
        "adminUsername": {
            "type": "string"
        },
        "adminPassword": {
            "type": "secureString"
        },
        "patchMode": {
            "type": "string"
        },
        "enableHotpatching": {
            "type": "bool"
        }
    },
    "variables": {
        "nsgId": "[resourceId(resourceGroup().name, 'Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroupName'))]",
        "vnetId": "[parameters('virtualNetworkId')]",
        "vnetName": "[last(split(variables('vnetId'), '/'))]",
        "subnetRef": "[concat(variables('vnetId'), '/subnets/', parameters('subnetName'))]"
    },
    "resources": [
        {
            "name": "[parameters('networkInterfaceName')]",
            "type": "Microsoft.Network/networkInterfaces",
            "apiVersion": "2021-08-01",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[concat('Microsoft.Network/networkSecurityGroups/', parameters('networkSecurityGroupName'))]",
                "[concat('Microsoft.Network/publicIpAddresses/', parameters('publicIpAddressName'))]"
            ],
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "properties": {
                            "subnet": {
                                "id": "[variables('subnetRef')]"
                            },
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIpAddress": {
                                "id": "[resourceId(resourceGroup().name, 'Microsoft.Network/publicIpAddresses', parameters('publicIpAddressName'))]",
                                "properties": {
                                    "deleteOption": "[parameters('pipDeleteOption')]"
                                }
                            }
                        }
                    }
                ],
                "enableAcceleratedNetworking": "[parameters('enableAcceleratedNetworking')]",
                "networkSecurityGroup": {
                    "id": "[variables('nsgId')]"
                }
            }
        },
        {
            "name": "[parameters('networkSecurityGroupName')]",
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2019-02-01",
            "location": "[parameters('location')]",
            "properties": {
                "securityRules": "[parameters('networkSecurityGroupRules')]"
            }
        },
        {
            "name": "[parameters('publicIpAddressName')]",
            "type": "Microsoft.Network/publicIpAddresses",
            "apiVersion": "2020-08-01",
            "location": "[parameters('location')]",
            "properties": {
                "publicIpAllocationMethod": "[parameters('publicIpAddressType')]"
            },
            "sku": {
                "name": "[parameters('publicIpAddressSku')]"
            }
        },
        {
            "name": "[parameters('virtualMachineName')]",
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "2022-03-01",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[concat('Microsoft.Network/networkInterfaces/', parameters('networkInterfaceName'))]"
            ],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "[parameters('virtualMachineSize')]"
                },
                "storageProfile": {
                    "osDisk": {
                        "createOption": "fromImage",
                        "managedDisk": {
                            "storageAccountType": "[parameters('osDiskType')]"
                        },
                        "deleteOption": "[parameters('osDiskDeleteOption')]"
                    },
                    "imageReference": {
                        "publisher": "microsoftwindowsdesktop",
                        "offer": "windows-11",
                        "sku": "win11-21h2-pro",
                        "version": "latest"
                    }
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaceName'))]",
                            "properties": {
                                "deleteOption": "[parameters('nicDeleteOption')]"
                            }
                        }
                    ]
                },
                "osProfile": {
                    "computerName": "[parameters('virtualMachineComputerName')]",
                    "adminUsername": "[parameters('adminUsername')]",
                    "adminPassword": "[parameters('adminPassword')]",
                    "windowsConfiguration": {
                        "enableAutomaticUpdates": true,
                        "provisionVmAgent": true,
                        "patchSettings": {
                            "enableHotpatching": "[parameters('enableHotpatching')]",
                            "patchMode": "[parameters('patchMode')]"
                        }
                    }
                },
                "licenseType": "Windows_Client",
                "diagnosticsProfile": {
                    "bootDiagnostics": {
                        "enabled": true
                    }
                }
            }
        }
    ],
    "outputs": {
        "adminUsername": {
            "type": "string",
            "value": "[parameters('adminUsername')]"
        }
    }
}
```
#### Variable
```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "location": {
            "value": "eastus"
        },
        "networkInterfaceName": {
            "value": "testvmw11101"
        },
        "enableAcceleratedNetworking": {
            "value": true
        },
        "networkSecurityGroupName": {
            "value": "testvmw11-nsg"
        },
        "networkSecurityGroupRules": {
            "value": [
                {
                    "name": "RDP",
                    "properties": {
                        "priority": 300,
                        "protocol": "TCP",
                        "access": "Allow",
                        "direction": "Inbound",
                        "sourceAddressPrefix": "*",
                        "sourcePortRange": "*",
                        "destinationAddressPrefix": "*",
                        "destinationPortRange": "3389"
                    }
                }
            ]
        },
        "subnetName": {
            "value": "subnet-clients"
        },
        "virtualNetworkId": {
            "value": "/subscriptions/3a970e11-b4aa-423d-91dc-18935c438bc4/resourceGroups/androcho-SIA-demo-001/providers/Microsoft.Network/virtualNetworks/vnet-spoke-client"
        },
        "publicIpAddressName": {
            "value": "testvmw11-ip"
        },
        "publicIpAddressType": {
            "value": "Static"
        },
        "publicIpAddressSku": {
            "value": "Standard"
        },
        "pipDeleteOption": {
            "value": "Detach"
        },
        "virtualMachineName": {
            "value": "testvmw11"
        },
        "virtualMachineComputerName": {
            "value": "testvmw11"
        },
        "virtualMachineRG": {
            "value": "androcho-SIA-demo-001"
        },
        "osDiskType": {
            "value": "Premium_LRS"
        },
        "osDiskDeleteOption": {
            "value": "Delete"
        },
        "virtualMachineSize": {
            "value": "Standard_D2s_v3"
        },
        "nicDeleteOption": {
            "value": "Detach"
        },
        "adminUsername": {
            "value": "akamai"
        },
        "adminPassword": {
            "value": null
        },
        "patchMode": {
            "value": "AutomaticByOS"
        },
        "enableHotpatching": {
            "value": false
        }
    }
}
```
