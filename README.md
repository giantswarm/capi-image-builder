[![CircleCI](https://circleci.com/gh/giantswarm/capi-image-builder.svg?style=shield)](https://circleci.com/gh/giantswarm/capi-image-builder)

# capi-image-builder chart

**What is this app?**

This app installs a collection of [Tekton] Pipelines and Tasks that make use of [image-builder] to create and share VM images for cluster-api providers.

**Who can use it?**

This app is primarily built for internal use in Giant Swarm but should be useable by others with minimal (if any) changes.

## Features

* Daily CronJob to check for new (non-alpha) releases of Kubernetes and if found, triggers new image builds.
* Event listener to trigger image builds for a given Kubernetes version, optionally targetting a specific provider.
* Retry on build failure with debug logging enabled on second run.

### Supported Platforms

| Provider | Supported base OS | Comments |
| --- | --- | --- |
| CAPG (GCP) | Ubuntu 18.04, Ubuntu 20.04 | Images are set to be publically shared with all GCP accounts |
| CAPA (AWS) | Ubuntu 20.04, Flatcar | Images set to public and replicated to regions: eu-central-1, eu-west-1, us-east-1, us-west-1. Root volumes must not be encrypted to allow the AMIs to be shared. |
| CAPO (OpenStack) | Ubuntu 20.04 | Images are built and pushed to an S3 (or compatible) bucket along with a sha256. Image compression is enabled to save storage space. |

## Configuration

### CAPA / AWS

A service account with the IAM policy below is required and the credentials need to be provided as `ami.accessKeyId` and `ami.secretAccessKey`.

```json
{
  "Version": "2012-10-17",
  "Statement": [{
      "Effect": "Allow",
      "Action" : [
        "ec2:AttachVolume",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CopyImage",
        "ec2:CreateImage",
        "ec2:CreateKeypair",
        "ec2:CreateSecurityGroup",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteKeyPair",
        "ec2:DeleteSecurityGroup",
        "ec2:DeleteSnapshot",
        "ec2:DeleteVolume",
        "ec2:DeregisterImage",
        "ec2:DescribeImageAttribute",
        "ec2:DescribeImages",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSnapshots",
        "ec2:DescribeSubnets",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume",
        "ec2:GetPasswordData",
        "ec2:ModifyImageAttribute",
        "ec2:ModifyInstanceAttribute",
        "ec2:ModifySnapshotAttribute",
        "ec2:RegisterImage",
        "ec2:RunInstances",
        "ec2:StopInstances",
        "ec2:TerminateInstances"
      ],
      "Resource" : "*"
  }]
}
```

### CAPG / GCP

A service account with the permissions listed below is required. The service account's key json should then be provided as `gcp.serviceAccountCredentialsJSON`.

```
compute.disks.create
compute.disks.delete
compute.disks.useReadOnly
compute.globalOperations.get
compute.images.create
compute.images.get
compute.images.getFromFamily
compute.images.getIamPolicy
compute.images.list
compute.images.setIamPolicy
compute.instances.create
compute.instances.delete
compute.instances.get
compute.instances.getSerialPortOutput
compute.instances.setLabels
compute.instances.setMetadata
compute.instances.setServiceAccount
compute.machineImages.setIamPolicy
compute.machineTypes.get
compute.subnetworks.use
compute.subnetworks.useExternalIp
compute.zoneOperations.get
compute.zones.get
iam.serviceAccounts.actAs
```

### CAPO / OpenStack

An S3 (or compatible) object store bucket is required to store the build images. The credentials and details for this bucket should be provided as the `s3` values object. e.g.

```yaml
s3:
  accessKeyId: "ACCESSKEYEXAMPLE"
  secretAccessKey: "SECRETACCESSKEY"
  endpointURL: "s3.eu-west-1.amazonaws.com"
  bucketName: "capo-images"
```

## Triggering Manual Build

It is possible to manually trigger a build, for example an older Kubernetes version, either for all providers or a specific provider.

> Tip: Apply the following with `kubectl create` to make use of the `generateName` property. This avoids name conflicts and the need to clean up jobs when running multiple times.

The following Job example shows how you can manually trigger the Tekton PipelineRun to build a **CAPA** image with Kubernetes **1.22.12**:

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  generateName: capi-image-build-manual-trigger
  namespace: capi-image-builder # Replace with the namespace the app is deployed into
spec:
  template:
    spec:
      containers:
      - name: curl
        image: curlimages/curl:latest
        command:
        - sh
        - -c
        - |
          curl -X POST http://el-capi-image-builder-build-capi-images-event-listener:8080 \
            -H 'Content-Type: application/json' \
            -d "{\"k8s\": { \"version\": \"1.22.10\" }, \"provider\":\"capa\"}"
      restartPolicy: Never
```

To build the same image for **all providers**, you can leave off the `provider` parameter, e.g.

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  generateName: capi-image-build-manual-trigger
  namespace: capi-image-builder # Replace with the namespace the app is deployed into
spec:
  template:
    spec:
      containers:
      - name: curl
        image: curlimages/curl:latest
        command:
        - sh
        - -c
        - |
          curl -X POST http://el-capi-image-builder-build-capi-images-event-listener:8080 \
            -H 'Content-Type: application/json' \
            -d "{\"k8s\": { \"version\": \"1.22.12\" }}"
      restartPolicy: Never
```

## Compatibility

An existing Tekton environment is required and has been tested with the following versions:

* Pipelines: v0.35.1
* Triggers: v0.20.1

[Tekton]: https://tekton.dev/
[image-builder]: https://image-builder.sigs.k8s.io/introduction.html
