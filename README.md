# Description

### Objective

This docker image shall contain all utilities to perform continuous integration steps from a Jenkins Slave:

* Using the `doctl` CLI tool to access resources managed by Digital Ocean
* Using `helm` CLI to package Helm Charts and deploy releases (helm3)
* Interacting with ChartMuseum using the `curl` command

### Dependencies

* Helm 3.2.1

