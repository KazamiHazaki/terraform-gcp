Requirements :

- Install [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Install [gcloud CLI](https://cloud.google.com/sdk/docs/install) and get your [credentials.json](https://cloud.google.com/iam/docs/keys-create-delete)

## List Services

- Google Cloud Storage
- Compute Instance
- Artifact Registry
- PubSub
- Cloud SQL

## Details List

### Google Cloud Storage

- 2 Bucket Private
- 1 Bucket Public

### Compute instance

Single VM with Specs :

- OS = Debian
- Disk = 10 GB SSD
- Machine Type = e2-micro
- 1 public IP

### Artifact Registry

1 Artifact registry for Docker

### PubSub

3 Topic with 3 Subscription

### Cloud SQL

Type : Mysql 8.0

Tier Machine : db-custom-2-8192

Disk Size : 10 GB SSD

deletion_protection : true

Database : 1 db name

User : 1 custom user with random password

Password policy 7x fail attempts

# How to Run ?

Before run make sure gcloud cli already installed and login in your cli

```bash
gcloud auth application-default login
```
or using JSON

```bash
export GOOGLE_APPLICATION_CREDENTIALS=~/gcp-key.json
gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
```
Change in terraform.tfvars with your spesified value

and make sure to change project_id

Then next to run terraform

1. Install dependencies terraform

```bash
terraform init
```

1. Run Terraform

```bash
terraform apply
```

output result 

![image](https://github.com/user-attachments/assets/630b0dd7-041c-45a9-be63-392f00244732)


for db_password its result <sensitive> to show the password is use command 

```bash
terraform output sql_db_password
```
