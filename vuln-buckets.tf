# Create vulnerabilities based on kics queries in https://docs.kics.io/latest/queries/terraform-queries/ 

# Granting the Bucket Access
resource "aws_s3_bucket_public_access_block" "publicaccess" {
  bucket = aws_s3_bucket.demobucket.id
  block_public_acls = false
  block_public_policy = false
}

# Creating the bucket named terraformdemobucket
resource "aws_s3_bucket" "demobucket" {
  bucket = "terraformdemobucket"
  acl = "private"
}
