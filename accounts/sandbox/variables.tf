variable "region" {}
variable "automation_role" {}
variable "cidr_block" {}
variable "az" {}
variable "master_account_id" {}

variable "transit_gateway_id" {
  description = "This ID is generated during the deployment of the Shared Transit Gateway in the Network Account"
}
################################################################################
# Variables for guardduty-baseline module.
################################################################################
variable "guardduty_finding_publishing_frequency" {}
