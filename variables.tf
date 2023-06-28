
variable "role_name_prefix" {
  type        = string
  description = "Role name prefix"
  default     = "PrismaCloudRole-"
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "account_group_ids" {
  type        = list(string)
  description = "Prisma Cloud Account Group Ids"
}
variable "features" {
  type        = list(string)
  description = "Prisma Cloud Protection mode. (MONITOR|MONITOR_AND_PROTECT)"
  default     = []
  validation {
    condition = alltrue([
      for feature in var.features : can(regex("^(Agentless\\sScanning|Auto\\sProtect|Data\\sSecurity|Remediation|Serverless\\sFunction\\sScanning)$", feature))
    ])
    # condition     = can(regex("^(Agentless\\sScanning|Auto\\sProtect|Data\\sSecurity|Remediation|Serverless\\sFunction\\sScanning)$", var.features))
    error_message = "Invalid input, options: \"Agentless Scanning\", \"Auto Protect\", \"Data Security\", \"Remediation\", \"Serverless Function Scanning\""
  }
}