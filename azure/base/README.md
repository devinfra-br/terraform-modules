
# Azure Virtual Network (VNet) Module

This Terraform module creates an Azure Virtual Network (VNet) along with subnets and an optional NAT Gateway. The module is designed to allow flexibility in configuring subnets with support for service delegation, and it can associate a NAT Gateway with specific subnets as required.

## Features

- Creates an Azure Virtual Network (VNet).
- Supports the creation of multiple subnets.
- Optionally configures a NAT Gateway for outbound internet access.
- Supports service delegation for specific subnets.

## Resources Created

This module will create the following resources:

- **Azure Virtual Network (VNet)**: The primary network resource.
- **Subnets**: Subnets within the VNet, each configurable with its own CIDR block.
- **NAT Gateway (Optional)**: Configured if enabled, and associated with specified subnets.
- **Public IP for NAT Gateway (Optional)**: A static public IP address used by the NAT Gateway.

## Usage

Below is an example of how to use this module in your Terraform configuration:

```hcl
module "network" {
  source              = "./path/to/module"
  location            = "East US"
  resource_group_name = "rg-network"
  vnet_name           = "my-vnet"
  vnet_cidr           = "10.0.0.0/16"
  
  subnets = {
    applications = {
      name           = "applications-subnet"
      cidr           = "10.0.1.0/24"
      use_nat_gateway = true
    }
    kubernetes = {
      name           = "kubernetes-subnet"
      cidr           = "10.0.2.0/24"
      use_nat_gateway = false
    }
    databases = {
      name           = "databases-subnet"
      cidr           = "10.0.3.0/24"
      use_nat_gateway = false
      delegation = {
        name = "delegation"
        service_delegation = {
          name    = "Microsoft.DBforMySQL/flexibleServers"
          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
        }
      }
    }
  }

  create_nat_gateway = true
  project            = "my-project"
  environment        = "dev"
  tags               = {
    environment = "dev"
    project     = "my-project"
  }
}
```

## Inputs

| Name                   | Description                                                                         | Type   | Default          | Required |
|------------------------|-------------------------------------------------------------------------------------|--------|------------------|----------|
| `location`             | Azure region where resources will be deployed (e.g., East US, West Europe)           | `string` | `""`             | Yes      |
| `resource_group_name`   | Name of the Azure Resource Group to create or use                                    | `string` | `"rg-network"`   | Yes      |
| `vnet_name`             | Name of the Virtual Network (VNet)                                                   | `string` | `""`             | Yes      |
| `vnet_cidr`             | CIDR block defining the address space for the Virtual Network (VNet)                 | `string` | `""`             | Yes      |
| `subnets`               | Map of subnets to be created in the VNet with options for NAT Gateway and delegation | `map`   | `{}`             | Yes      |
| `create_nat_gateway`    | Boolean flag to control whether a NAT Gateway is created                             | `bool`  | `false`          | No       |
| `tags`                  | Map of key-value pairs to associate tags with resources for identification           | `map`   | `{}`             | No       |
| `project`               | Project name to be used in resource naming and tagging                               | `string` | `""`             | Yes      |
| `environment`           | Name of the environment (e.g., dev, staging, prod)                                   | `string` | `""`             | Yes      |

## Outputs

| Name     | Description                          |
|----------|--------------------------------------|
| `vnet_id` | ID of the created Virtual Network (VNet) |

## NAT Gateway

The module provides an optional NAT Gateway. If `create_nat_gateway` is set to `true`, the module will create:

- A NAT Gateway.
- A static Public IP address associated with the NAT Gateway.
- NAT Gateway association with specified subnets that have `use_nat_gateway` set to `true`.

## Subnets

Each subnet can be configured independently with the following options:

- **CIDR Block**: Each subnet must have its own CIDR block.
- **Use NAT Gateway**: If `true`, the subnet will be associated with the NAT Gateway.
- **Service Delegation (Optional)**: Subnets can optionally be configured with a service delegation. This is useful for services such as Azure Database for MySQL.

## Example with Service Delegation

```hcl
subnets = {
  databases = {
    name = "databases-subnet"
    cidr = "10.0.3.0/24"
    use_nat_gateway = false
    delegation = {
      name = "delegation"
      service_delegation = {
        name    = "Microsoft.DBforMySQL/flexibleServers"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      }
    }
  }
}
```

## Tags

Tags can be applied to all resources created by this module by passing a map of key-value pairs to the `tags` variable. For example:

```hcl
tags = {
  environment = "dev"
  project     = "my-project"
}
```

## License

This module is licensed under the MIT License. See the LICENSE file for more details.
