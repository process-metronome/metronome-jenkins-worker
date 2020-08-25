# Description

### Objective

This docker image shall contain all utilities to perform continuous integration steps from a Jenkins Slave:

* Using the `doctl` CLI tool to access resources managed by Digital Ocean
* Using the `terraform` CLI tool to deploy any stack
* Interacting with ChartMuseum using the `curl` command


### How to use it
#### Docker CLI
Use docker login with your Github ID as username and Github Access Token as password. The Access Token should be associated with the 
packages:read role.

#### Kubernetes
You must create a docker credential in the target namespace.

```bash
kubectl create secret docker-registry github-packages \
    --namespace $RELEVANT_NAMESPACE \
    --docker-server=docker.pkg.github.com \ 
    --docker-username=$YOUR_GITHUB_ID \
    --docker-password=$YOUR_GITHUB_ACCESS_TOKEN
```

Then the docker pull secret field must be set in any deployment using this container image `docker.pkg.github.com/process-metronome/metronome-jenkins-worker/metronome-jenkins-worker:latest`


#### Jenkins Pipeline
