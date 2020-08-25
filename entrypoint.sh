#!/bin/bash

# Create terraform credential
echo "Creating terraform credentials..."
if ! [ -z "$TF_API_TOKEN" ]; then
  cat << EOL > /home/jenkins/.terraformrc
credentials "app.terraform.io" {
  token = "$TF_API_TOKEN"
}
EOL
  echo "Successfully loaded credentials into /home/jenkins/.terraformrc."
  terraform version
fi

# Login Terraform
if ! [ -z "$DIGITALOCEAN_ACCESS_TOKEN" ]; then
  echo "Login to Digital Ocean account... "
  doctl auth init -t "$DIGITALOCEAN_ACCESS_TOKEN"
  if ! [ -z "$DIGITALOCEAN_REGISTRY" ]; then
    echo "Login to the Digital Ocean Docker Registry..."
    doctl registry login
  fi
fi

exec jenkins-agent -url https://jenkins.eu "$1" "$2"