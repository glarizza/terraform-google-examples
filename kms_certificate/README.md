# Managing a certificate with Google KMS

1. Generate a self-signed certificate: `openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem`
2. Create `terraform.tfvars` in the root of this directory and populate it with values for `project_id` and `region`
3. Apply the Terraform code for key/keyring by targeting its module specifically: `terraform init && terraform apply -target module.keyring_and_key`
4. Encrypt the certificate and the private key by hand with the following commands:

```
cat certificate.pem | gcloud kms encrypt \
--project <PROJECT_ID> \
--location <REGION> \
--keyring demo-key-ring \
--key demo-crypto-key \
--plaintext-file - \
--ciphertext-file - \
| base64
```

```
cat key.pem | gcloud kms encrypt \
--project <PROJECT_ID> \
--location <REGION> \
--keyring demo-key-ring \
--key demo-crypto-key \
--plaintext-file - \
--ciphertext-file - \
| base64
```

4. Each command will output a ciphertext string that can be used to set the `certificate_ciphertext` and `key_ciphertext` input variables in `terraform.tfvars`
5. Run `terraform apply` to generate the SSL certificate based on the encrypted secret values

