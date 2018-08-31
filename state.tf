terraform {
  backend "s3" {
    bucket         = "my-ember-tf-state"
    key            = "state"
    region         = "eu-central-1"
    profile        = "emberjs"
    dynamodb_table = "my-ember-tf-state"
  }
}
