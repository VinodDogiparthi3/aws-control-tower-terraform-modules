output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.SharedNetwork_TGW.id
  description = "Transit gateway id to share across accounts"
}
