This is a terraform part of Scaleway version of kube-desktop.

To launch terraform provisioner, do the following:

1. Create a file called **environment**, with following contents:

```
export SSH_KEY=~/.ssh/id_rsa
export SCALEWAY_ORGANIZATION=<org id>
export SCALEWAY_ORG_TOKEN=<org id>
export SCALEWAY_TOKEN=<scaleway secret key>

```

2. Source that file: ```source ./environment```
3. If you want to optionally store the terraform state on Scaleway's S3, then create a **backend.tf** file:

```
terraform {
    backend "s3" {
        bucket      = "tfstate-kubedesktop"
        key         = "me_state.tfstate"
        region      = "nl-ams"
        endpoint    = "https://s3.nl-ams.scw.cloud"
        access_key  = "<scaleway s3 access_key>"
        secret_key  = "<scaleway s3 secret_key>"
        skip_credentials_validation = true
        skip_region_validation = true
    }
}

```

Note that this breaks ansible provisioner, as it's no longer able to access TF state for inventory.

4. Once you have all of above done, ```terraform init``` and then ```terraform apply``` will create your environment.
