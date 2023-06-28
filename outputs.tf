output "aws_role_arn" {
  value       = aws_iam_role.this.arn
  description = "Prisma Cloud AWS IAM Role ARN"
}

output "prisma_cloud_account_id" {
  value       = prismacloud_cloud_account_v2.this.id
  description = "Prisma Cloud Account Id"
}