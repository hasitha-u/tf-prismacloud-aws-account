resource "prismacloud_account_group" "example" {
  name        = "My Account Group"
  description = "Made by Terraform"

  lifecycle {
    ignore_changes = [
      # ignore changes to the account_ids, as they will be added during account onboarding
      account_ids,
    ]
  }
}

module "example" {

  source            = "../"
  account_group_ids = [prismacloud_account_group.example.group_id]
  features          = ["Auto Protect", "Remediation"]
}
