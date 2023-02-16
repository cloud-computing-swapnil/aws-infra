# aws-infra
pre requisites

Install terraform in your system
https://www.terraform.io/downloads.html

Type terraform -v in your terminal to check terraform version

Install Aws cli in your system
https://aws.amazon.com/cli/

Type aws --version 

Type aws configure --profile dev

You will be asked to provide credentials which you can find by creating access keys in your AWS Console

Steps to run app using terraform infrastructure as code

Clone git repository to your local system and navigate to the project in Terminal using cd aws-infra

use cmd terraform init

Then use terraform plan 

Then apply terraform apply 

you can see the changes inside the aws console
