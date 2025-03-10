# AWS-Networking-Test

This creates an OpenVPN instance and a Ubuntu instance in us-east-1 and the AWS network infrastructure to support it.

# **network.tf**

network.tf creates a VPC 192.168.1.0/24 and two subnets in us-east-1a and us-east-1b with CIDRs 192.168.1.0/25 and 192.168.1.128/25 respectively. These are the subnets that the OpenVPN and Ubuntu instances are hosted in.

network.tf also creates an AWS Internet Gateway that provides internet access for the instances and configures the appropriate network routing tables ands to allow connectivity between the instances.


# **outputs.tf**

This outputs the public IP address of the OpenVPN instance. AWS auto assigns a public IP when you use `associate_public_ip_address = true` in terraform. This output allows us to grab the public IP which will be used later for OpenVPN configuration


# **providers.tf**

basic provider set up. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs for more information


# **security.groups.tf**

Creates open wide open security groups to allow full access between services. In a real environment, this will be much more granular.


# **vpn-ec2.tf**

This creates the OpenVPN instance and references an SSH key that is not included in this repo. Please see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair for more information but managing aws keys with terraform still has much to be desired 

# **service-ec2.tf**

This creates an ubuntu instance that acts as our service. We will ping this instance to verify connectivity to servers across the VPN

# Diagram

<img width="725" alt="Screenshot 2025-03-06 at 9 39 21 PM" src="https://github.com/user-attachments/assets/ff7f7722-53a0-4306-be34-f29b3b4d4484" />

This show the AWS infrastructure. A user connects to the OpenVPN through the instances. Traffic is routed through the IGW to the OpenVPN instance and traffic to AWS infrastructure is tunneled through the VPN


# Connecting to OpenVPN

Download the OpenVPN client here https://openvpn.net/client/

SSH to your AWS instance using the key pair you created and the auto assigned public IP of your instance. You can grab the public IP from the output. Go through the OpenVPN CLI configuration (you can just hit yes for most default answers but remember to set your password)

When you are done, open the OpenVPN client. In URL, enter the URL of your server which is the auto assigned public IP address. Click Next. Then enter your username and password and click import. Toggle the connect button and you should be able to connect! Ping your ubuntu instance to verify connectivity.
