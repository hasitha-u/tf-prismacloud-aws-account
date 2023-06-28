resource "prismacloud_account_group" "example" {
  name        = "My Account Group"
  description = "Made by Terraform"
}

module "example" {

  source            = "../"
  account_group_ids = ["${prismacloud_account_group.example.group_id}"]
  features = ["Auto Protect","Remediation"]
}
