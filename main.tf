locals {
  # ARNs of managed policies to be attached to Prisma Cloud Role
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/SecurityAudit",
  ]

  #Only enable supported features
  features = setintersection(var.features, data.prismacloud_account_supported_features.this.supported_features)
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "this" {
  name               = "${var.role_name_prefix}${data.aws_caller_identity.current.account_id}"
  assume_role_policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": {
				"AWS": "arn:aws:iam::188619942792:root"
			},
			"Action": "sts:AssumeRole",
			"Condition": {
				"StringEquals": {
					"sts:ExternalId": [
						"${data.prismacloud_aws_cft_generator.this.external_id}"
					]
				}
			}
		}
	]
}
EOF

  tags = var.tags

}

# Config Scan policeis contains permissions required for Misconfigurations(CSPM), Identity Security, Threat Detection features which are is enabled by default
resource "aws_iam_policy" "config_scan" {
  for_each = { for path in fileset(path.module, "policies/ConfigScan/*.json") : "${var.role_name_prefix}${split(".", basename(path))[0]}" => path }

  name        = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  path        = "/"
  description = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  policy      = file("${path.module}/${each.value}")
  tags        = var.tags
}

# Permissions required for the `Agentless` feature
resource "aws_iam_policy" "agentless" {
  for_each = contains(local.features, "Agentless Scanning") ? { for path in fileset(path.module, "policies/AgentlessScanning/*.json") : "${var.role_name_prefix}${split(".", basename(path))[0]}" => path } : {}

  name        = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  path        = "/"
  description = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  policy      = file("${path.module}/${each.value}")
  tags        = var.tags
}

# Permissions required for the `Auto Protect (Agent-Based Workload Protection)` feature
resource "aws_iam_policy" "auto_protect" {
  for_each = contains(local.features, "Auto Protect") ? { for path in fileset(path.module, "policies/AutoProtect/*.json") : "${var.role_name_prefix}${split(".", basename(path))[0]}" => path } : {}

  name        = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  path        = "/"
  description = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  policy      = file("${path.module}/${each.value}")
  tags        = var.tags
}

# Permissions required for the `Data Security` feature
resource "aws_iam_policy" "data_security" {
  for_each = contains(local.features, "Data Security") ? { for path in fileset(path.module, "policies/DataSecurity/*.json") : "${var.role_name_prefix}${split(".", basename(path))[0]}" => path } : {}

  name        = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  path        = "/"
  description = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  policy      = file("${path.module}/${each.value}")
  tags        = var.tags
}

# Permissions required for the `Remediation` feature
resource "aws_iam_policy" "remediation" {
  for_each = contains(local.features, "Remediation") ? { for path in fileset(path.module, "policies/Remediation/*.json") : "${var.role_name_prefix}${split(".", basename(path))[0]}" => path } : {}

  name        = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  path        = "/"
  description = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  policy      = file("${path.module}/${each.value}")
  tags        = var.tags
}

# Permissions required for the `Serverless Function Scanning` feature
resource "aws_iam_policy" "serverless_function_scanning" {
  for_each = contains(local.features, "Serverless Function Scanning") ? { for path in fileset(path.module, "policies/ServerlessFunctionScanning/*.json") : "${var.role_name_prefix}${split(".", basename(path))[0]}" => path } : {}

  name        = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  path        = "/"
  description = "${var.role_name_prefix}${split(".", basename(each.value))[0]}"
  policy      = file("${path.module}/${each.value}")
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  for_each = { for arn in toset(local.managed_policy_arns) : "AWSManaged-${split("/", arn)[1]}" => arn }

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "config_scan" {
  for_each = aws_iam_policy.config_scan

  role       = aws_iam_role.this.name
  policy_arn = each.value.arn
}

resource "aws_iam_role_policy_attachment" "agentless" {
  for_each = aws_iam_policy.agentless

  role       = aws_iam_role.this.name
  policy_arn = each.value.arn
}

resource "aws_iam_role_policy_attachment" "auto_protect" {
  for_each = aws_iam_policy.auto_protect

  role       = aws_iam_role.this.name
  policy_arn = each.value.arn
}

resource "aws_iam_role_policy_attachment" "data_security" {
  for_each = aws_iam_policy.data_security

  role       = aws_iam_role.this.name
  policy_arn = each.value.arn
}

resource "aws_iam_role_policy_attachment" "remediation" {
  for_each = aws_iam_policy.remediation

  role       = aws_iam_role.this.name
  policy_arn = each.value.arn
}

resource "aws_iam_role_policy_attachment" "serverless_function_scanning" {
  for_each = aws_iam_policy.serverless_function_scanning

  role       = aws_iam_role.this.name
  policy_arn = each.value.arn
}

#Prisma Cloud Account Configuration
data "prismacloud_aws_cft_generator" "this" {
  account_type = "account"
  account_id   = data.aws_caller_identity.current.account_id
}

data "prismacloud_account_supported_features" "this" {
  cloud_type   = "aws"
  account_type = "account"
}

resource "prismacloud_cloud_account_v2" "this" {
  disable_on_destroy = var.disable_on_destroy
  aws {
    name       = var.account_name
    account_id = data.aws_caller_identity.current.account_id
    group_ids  = var.account_group_ids
    role_arn   = aws_iam_role.this.arn
    dynamic "features" {
      for_each = local.features
      content {
        name  = features.value
        state = "enabled"
      }
    }
  }
}