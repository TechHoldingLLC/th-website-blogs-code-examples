# Hosting static website on GCP

## Authenticate to your GCP account

Install the Google Cloud CLI, then initialize it by running the following command:

```console
gcloud init
```

If you're using a local shell, then create local authentication credentials for your user account:

```console
gcloud auth application-default login --project <project-id>
```

## Deploy resources using terraform 
Initialize terraform to download providers and setup working directory

```console
terraform init
```

Create terraform plan to preview the changes

```console
terraform plan
```
If plan looks good then apply that plan to create resources

```console
terraform apply
```
