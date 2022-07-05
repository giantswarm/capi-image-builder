[![CircleCI](https://circleci.com/gh/giantswarm/capi-image-builder.svg?style=shield)](https://circleci.com/gh/giantswarm/capi-image-builder)

# capi-image-builder chart

Giant Swarm offers a capi-image-builder App which can be installed in workload clusters.
Here we define the capi-image-builder chart with its templates and default configuration.

**What is this app?**

## Architecture

There are two major parts of this app.

1) ( Detect ) Detecting new k8s that need to be built
2) ( Build ) Building image and publishing it.

Part 1)

 - Look at kubernetes releases and get a list of releases available
 - Look at output location and detect what versions are already present
 - Compare the two list and start a build of the missing releases

Part 2)

 - Build the kubernetes capi image
 - Publish to the specified output location



**Why did we add it?**

**Who can use it?**

## Installing

There are several ways to install this app onto a workload cluster.

- [Using our web interface](https://docs.giantswarm.io/ui-api/web/app-platform/#installing-an-app).
- By creating an [App resource](https://docs.giantswarm.io/ui-api/management-api/crd/apps.application.giantswarm.io/) in the management cluster as explained in [Getting started with App Platform](https://docs.giantswarm.io/app-platform/getting-started/).

## Configuring

### values.yaml

**This is an example of a values file you could upload using our web interface.**

```yaml
# values.yaml

```

### Sample App CR and ConfigMap for the management cluster

If you have access to the Kubernetes API on the management cluster, you could create
the App CR and ConfigMap directly.

Here is an example that would install the app to
workload cluster `abc12`:

```yaml
# appCR.yaml

```

```yaml
# user-values-configmap.yaml

```

See our [full reference on how to configure apps](https://docs.giantswarm.io/app-platform/app-configuration/) for more details.

## Compatibility

This app has been tested to work with the following workload cluster release versions:

- _add release version_

## Limitations

Some apps have restrictions on how they can be deployed.
Not following these limitations will most likely result in a broken deployment.

- _add limitation_

## Credit

- {APP HELM REPOSITORY}
