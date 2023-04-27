#!/bin/bash

# Download Terraform
wget https://releases.hashicorp.com/terraform/1.0.8/terraform_1.0.8_linux_amd64.zip

# Unzip the downloaded file
unzip terraform_1.0.8_linux_amd64.zip

# Move the Terraform binary to /usr/local/bin
sudo mv terraform /usr/local/bin/

# Verify installation by checking Terraform version
terraform version