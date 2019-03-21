# Managing a certificate with Google KMS

1. Generate a self-signed certificate: `openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem`
2. Create `terraform.tfvars` and populate with `project_id` and `region`
3. Apply the Terraform code for key/keyring: `terraform init && terraform apply -target module.keyring_and_key`
4. Encrypt the certificate and the private key:

```
cat certificate.pem | gcloud kms encrypt \
--project simple-sample-project-f0cb \
--location us-west1 \
--keyring example-key-ring \
--key example-crypto-key \
--plaintext-file - \
--ciphertext-file - \
| base64
```

```
cat key.pem | gcloud kms encrypt \
--project simple-sample-project-f0cb \
--location us-west1 \
--keyring example-key-ring \
--key example-crypto-key \
--plaintext-file - \
--ciphertext-file - \
| base64
```

4. Use those values to set `certificate_ciphertext` and `key_ciphertext` in `terraform.tfvars`
5. Run `terraform apply` to generate SSL certificate

