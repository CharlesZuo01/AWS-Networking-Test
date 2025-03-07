# AWS-Networking-Test

This creates an OpenVPN instance and a Ubuntu instance in us-east-1 and the AWS network infrastructure to support it.

network.tf

network.tf creates a VPC 192.168.1.0/24 and two subnets in us-east-1a and us-east-1b with CIDRs 192.168.1.0/25 and 192.168.1.128/25 respectively. These are the subnets that the OpenVPN and Ubuntu instances are hosted in.

network.tf also creates an AWS Internet Gateway that provides internet access for the instances and configures the appropriate network routing tables ands to allow connectivity between the instances.


outputs.tf

This outputs the public IP address of the OpenVPN instance. AWS auto assigns a public IP when you use `associate_public_ip_address = true` in terraform. This output allows us to grab the public IP which will be used later for OpenVPN configuration


providers.tf

basic provider set up. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs for more information


security.groups.tf

Creates open wide open security groups to allow full access between services. In a real environment, this will be much more granular.


vpn-ec2.tf

This creates the OpenVPN instance and references an SSH key that is not included in this repo. Please see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair for more information but managing aws keys with terraform still has much to be desired 

service-ec2.tf

This creates an ubuntu instance that acts as our service. We will ping this instance to verify connectivity to servers across the VPN
