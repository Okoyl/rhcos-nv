# CUSTOM RHCOS


### Prepare
Set envrioment variables
```sh
export RHCOS_VERSION=4.21.0-rc.2
# OpenShift Pull Secret
export PULL_SECRET="~/pull-secret.json"
```

Set Image target
```sh
export TARGET_IMAGE=$(oc adm release info --image-for rhel-coreos "quay.io/openshift-release-dev/ocp-release:"$RHCOS_VERSION"-aarch64")
```

### Build Red Hat CoreOS Artifacts
```sh
podman build -f rhcos.containerfile \
          --authfile $PULL_SECRET \
          --build-arg TARGET_IMAGE=$TARGET_IMAGE \
          --build-arg KERNEL_REPO=<kernel repo> \
          --tag "rhcos-cs:$RHCOS_VERSION-latest"
```
