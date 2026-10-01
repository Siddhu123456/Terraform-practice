terraform {
  backend "s3" {
    bucket       = "techv-tfstate-dev-950102957515"
    key          = "terraform-practice/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}