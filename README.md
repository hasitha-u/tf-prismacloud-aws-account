# tf-prismacloud-aws-account
Terraform Module for onboarding an AWS account to Prisma Cloud

## Usage

```hcl
module "example" {

  source            = "github.com/hasitha-u/tf-prismacloud-aws-account"
  account_group_ids = ["${prismacloud_account_group.example.group_id}"]
  features          = ["Auto Protect","Remediation"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_prismacloud"></a> [prismacloud](#requirement\_prismacloud) | >= 1.4.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |
| <a name="provider_prismacloud"></a> [prismacloud](#provider\_prismacloud) | >= 1.4.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.agentless](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.auto_protect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.config_scan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.data_security](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.remediation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.serverless_function_scanning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.agentless](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.auto_protect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.config_scan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.data_security](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.remediation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.serverless_function_scanning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [prismacloud_cloud_account_v2.this](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/cloud_account_v2) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [prismacloud_account_supported_features.this](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/data-sources/account_supported_features) | data source |
| [prismacloud_aws_cft_generator.this](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/data-sources/aws_cft_generator) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_group_ids"></a> [account\_group\_ids](#input\_account\_group\_ids) | Prisma Cloud Account Group Ids | `list(string)` | n/a | yes |
| <a name="input_features"></a> [features](#input\_features) | Prisma Cloud Protection mode. (MONITOR\|MONITOR\_AND\_PROTECT) | `list(string)` | `[]` | no |
| <a name="input_role_name_prefix"></a> [role\_name\_prefix](#input\_role\_name\_prefix) | Role name prefix | `string` | `"PrismaCloudRole-"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | Prisma Cloud AWS IAM Role ARN |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
