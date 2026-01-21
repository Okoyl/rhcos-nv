# CUSTOM RHCOS


### Prepare
Set envrioment variables
```sh
export RHCOS_VERSION=4.21.0-rc.2
# OpenShift Pull Secret
export PULL_SECRET="~/pull-secret.json"
```
### Build OCP Container Image Layer
Set Image target
```sh
export TARGET_IMAGE=$(oc adm release info --image-for rhel-coreos "quay.io/openshift-release-dev/ocp-release:"$RHCOS_VERSION"-aarch64")
# or
export TARGET_IMAGE=$(oc adm release info --image-for rhel-coreos-10 "quay.io/openshift-release-dev/ocp-release:"$RHCOS_VERSION"-aarch64")
# Build your own OCP container image layer
podman build -f rhcos.containerfile \
          --authfile $PULL_SECRET \
          --build-arg TARGET_IMAGE=$TARGET_IMAGE \
          --build-arg KERNEL_REPO=<kernel repo> \
          --tag "rhcos-cs:$RHCOS_VERSION-latest"
```

### Build Driver Toolkit Container Image Layer
```sh
# Point to the base image for the driver toolkit
export BUILDER_IMAGE=$(oc adm release info --image-for driver-toolkit "quay.io/openshift-release-dev/ocp-release:"$RHCOS_VERSION"-aarch64")
# Build your own driver toolkit image
podman build -f driver-toolkit.containerfile \
          --authfile $PULL_SECRET \
          --build-arg BUILDER_IMAGE="rhcos-cs:$RHCOS_VERSION-latest" \
          --build-arg KERNEL_REPO=<kernel repo> \
          --tag "driver-toolkit-cs:$RHCOS_VERSION-latest"
```