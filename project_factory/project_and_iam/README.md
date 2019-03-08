# Project Factory: Project and IAM permissions

This directory contains Terraform configuration to create a Project with
Project Factory, and then independently create a project-based custom role and
bind that role to the default compute service account that's created by Project
Factory.

This configuration is useful in the event you want to use the default compute
service account that's created by Project Factory for your individual instances
while also restricting access based on a custom role.
