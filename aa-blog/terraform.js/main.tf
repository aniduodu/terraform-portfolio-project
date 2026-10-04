provider "aws" {
    region = "eu-west-2"

}

# S3 Bucket 
resource "aws_s3_bucket" "nextjs_bucket" {
    bucket = nextjs-portfolio-bucket-aa

}

# Ownership Control
resource "aws_s3_bucket_ownership_control" "nectjs_bucket_onership_controls" {
    bucket = "aws_s3_bucket.nextjs_bucket.id"
    rule {
        Object_onership = "bucketOwnerprefererd"
    }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "nextjs_bucket_public_access_block" {
    Bucket = aws_s3_bucket_nextjs_bucket.id

    block_public_acl= false
    block_public_policy = false
    ignore_public_acl = false
    restrict_public buckets = false

}

# Bucket Acl
resource "aws_s3_bucket_acl" "nextjs_bucket_acl"{
    depends_on = [
        aws_s3_bucket_ownership_controls.nextjs,
        aws_s3_bucket_public_access_block.nextjs_bucket_public_access_block

     ]
    bucket = aws_s3_bucket.nextjs_bucket.id
    acl = "public-read"
}

# Bucket Policy
Resource "aws_s3_bucket_policy" "nextjs_bucket_policy" {
    bucket = aws_s3_bucket_nextjs_bucket.id

    policy = jsondecode(({
        version = "2012-10-17"
        statement = [
            {
              sid = "PublicReadGetObject"
              Effect = "Allow"
              Pincipal = "*"
              Action = "s3:GetObject"
              Resource = "${aws_s3_bucket_nextjs_bucket.nextjs_bucket.arn}/*"
            }
        ]
    }))
}