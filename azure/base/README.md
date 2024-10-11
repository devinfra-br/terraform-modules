
# Terraform Module - Virtual Network with Subnets

This Terraform module creates a **Virtual Network (VNet)** and associated **Subnets** in Azure. The module supports multiple subnets that can be customized through input variables, designed to be used in different layers of applications such as frontend, backend (for Kubernetes), databases, and management.

## Resources Created

- Azure Virtual Network (VNet)
- Subnets for applications, Kubernetes, databases, and management

## Usage

Below is an example of how to use this module:

```hcl
module "network" {
  source              = "./path/to/this/module"
  
  vnet_name           = "my-vnet"
  resource_group_name = "my-resource-group"
  location            = "East US"
  vnet_cidr           = "10.0.0.0/16"

  subnets = {
    frontend = {
      name = "apps-subnet"
      cidr = "10.0.1.0/24"
    }
    backend = {
      name = "k8s-subnet"
      cidr = "10.0.2.0/24"
    }
    data = {
      name = "db-subnet"
      cidr = "10.0.3.0/24"
    }
    management = {
      name = "management-subnet"
      cidr = "10.0.4.0/24"
    }
  }

  tags = {
    environment = "production"
    project     = "vnet-setup"
  }
}
```

## Inputs

| Name                | Description                                | Type   | Default  | Required |
|---------------------|--------------------------------------------|--------|----------|----------|
| `vnet_name`          | The name of the Virtual Network            | string | n/a      | yes      |
| `resource_group_name`| Name of the resource group                 | string | n/a      | yes      |
| `location`           | The Azure region where resources are created | string | n/a    | yes      |
| `vnet_cidr`          | The CIDR block for the Virtual Network     | string | n/a      | yes      |
| `subnets`            | A map of subnets to create                 | map    | n/a      | yes      |
| `tags`               | Tags to associate with the resources       | map    | `{}`     | no       |

## Outputs

None for this module.

## Subnet Structure

The subnets are defined as a map with the following structure:

```hcl
subnets = {
  frontend = {
    name = "apps-subnet"
    cidr = "10.0.1.0/24"
  }
  backend = {
    name = "k8s-subnet"
    cidr = "10.0.2.0/24"
  }
  data = {
    name = "db-subnet"
    cidr = "10.0.3.0/24"
  }
  management = {
    name = "management-subnet"
    cidr = "10.0.4.0/24"
  }
}
```

## Tags

The module allows the use of tags for resources. Tags can be defined as a map.

## License

This module is licensed under the MIT License. See [LICENSE](./LICENSE) for full details.
