# aws-infra

Pre requisites

Install terraform in your system
https://www.terraform.io/downloads.html
xx
Type ```terraform -v``` in your terminal to check terraform version

Install AWS cli in your system
https://aws.amazon.com/cli/

Type ```aws --version``` in your terminal to check aws cli version

Create dev profile using aws cli
Type ```aws configure --profile dev```

You will be asked to provide credentials which you can find by creating access keys in your AWS Console

Steps to run app using terraform infrastructure as code

Clone git repository to your local system and navigate to the project in Terminal using cd aws-infra

Type ```terraform init```

Type ```terraform plan``` to check the deployment plan

Type ```terraform apply``` to apply the changes to the cloud infrastructure


Assignment-4: 
Create EC2 Instance with Terraform and attach security group to it.

