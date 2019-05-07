# GKE Basic Setup

This module will create a new project, setup a VPC network and subnet with
secondary ranges for Kubernetes, setup a basic regional Kubernetes cluster,
and configure IAM bindings to ensure I have access to the cluster and compute
engine.

## Requirements

* SA with enough permissions to create a project, create a network, and assign IAM permissions at the project level
* Access to the state bucket (substitute yours for mine)