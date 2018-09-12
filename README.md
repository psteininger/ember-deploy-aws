# Terraform Example Project for Automating Ember App Deployment

This project contains sample code to illustrate some of the key capabilities of Terraform.
There are 2 modules `hosting` and `ci`. 

The `hosting` module is a declaration of the components and configuration 
necessary in order to host an Ember application. This consists of S3 Bucket, a Cloudfront Distribution and 
Cloudflare DNS entry pointing to the distribution, and all necessary Roles and Policies

The `ci` module contains a CodeBuild Project, Webhooks, and all the Roles and Permissions necessary to automate 
the deployment to the infrastructure set up in `hosting`.

The project also uses remote state in S3 with locking using DynamoDB. This feature allows for even greater level of 
modularity, and at the minimum for collaboration between two or more teammates.

Terraform allows for setting up workspaces, which can be used for separating `staging` and `production` environments 
and having fine-grained control regarding parity and variance between environments.

There is a companion example Ember app, which contains a setup for environment variables and `buildspec.yml` file.
I also encourage you to review the commit history, as I tried to illustrate everything in clear logical steps.

## Purpose
The purpose of this, an the Ember App repos are to illustrate the capabilities of Terraform, and to serve as a learning 
example, for that reason the entire code base is MIT licensed. I encourage participation and collaboration, and welcome 
any contributions to make this a more reusable piece of code. 

## Contributing
Please feel free to open up issues and create pull requests. All feedback and contributions welcome.

## References
* Example Ember App 
  * https://github.com/psteininger/ember-deploy-app
* Blog Post with Step-by-Step 
  * https://medium.com/@piotr.steininger/

## Resources
* Terraform Docs
  * https://www.terraform.io/docs/index.html
* AWS Docs
	* https://aws.amazon.com/documentation/
* AWS Help in Berlin
	* Renato Losio - http://arsenio.it
