terraform {
    backend "s3" {
        bucket = "terra-project-s3-bucket-aa"
        key = "global/s3/terraform.tfstate"
        region = "eu-central-1"
        dynamodb_table = "my-db-website-table"
    }
}