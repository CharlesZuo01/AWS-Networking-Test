output "service_private_ip" {
  value       =  aws_instance.service.private_ip
  description = "The public url address of the vpn server"
}

output "access_vpn_url" {
  value       = "https://${aws_instance.openvpn.public_ip}:943/admin"
  description = "The public url address of the vpn server"
}