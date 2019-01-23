# vault_ami


### Known Issues

1. CodeBuild / Packer creates EC2 images, but does not clean them up if the build is stopped or fails.  Will need to create a process to manage clean-up of packer ec2 instances that are more than 12hrs old. Might be able to create a lambda function that is executed every time a build is launched.

