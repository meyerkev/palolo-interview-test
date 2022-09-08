# palolo-interview-test

So this is a test of our new SRE IAC interview.  This code consists o: 

1. a module modules/s3_bucket which is a module for standing up S3 buckets in Terraform without making devs down 
2. main.tf which is some example test code to ensure this all works.  

I wanted to stand this up so that I could validate our IAM posture and ensure we had at least some reasonable permissions.  

In the real interview, we make you expand this README a bit more to explain some example code, but this is merely a gut check.  

## How to run it

This will spin up a bunch of custom buckets

```
# Alt: If you're coming back to this: terraform init -upgrade
terraform init 

terraform apply
```

# To wipe out everything:

```
terraform destroy
```

Also consider the merits of just running `aws-nuke`
