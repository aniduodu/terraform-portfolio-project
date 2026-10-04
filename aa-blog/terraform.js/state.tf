terraform {
    backend "s3" {
        bucket = "ani-terraform-bucket"
        key = "global/s3/terraform.tfstate"
        region = "eu-central-1"
        dynamodb_table = "s3-tf-table"
    }
}