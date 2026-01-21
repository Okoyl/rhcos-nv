ARG BUILDER_IMAGE

FROM ${BUILDER_IMAGE} AS base

ARG KERNEL_REPO

RUN \
  curl ${KERNEL_REPO} > /etc/yum.repos.d/kernel.repo && \
  echo 'sslverify=0' >> /etc/yum.repos.d/kernel.repo

RUN \
  rpm -qa | grep '^kernel' | xargs -r rpm -v -e --nodeps && \
  dnf install -y \
    kernel \
    kernel-core \
    kernel-modules \
    kernel-modules-core \
    kernel-modules-extra \
    kernel-devel \
    kernel-devel-matched \
    kernel-headers \
    kernel-rpm-macros \
    kernel-srpm-macros.noarch \
  && \
  dnf clean all && \
  KVER=$(ls -1 /usr/src/kernels); \
  sed -i "s/\"KERNEL_VERSION\"[[:space:]]*:[[:space:]]*\"[^\"]*\"/\"KERNEL_VERSION\": \"$KVER\"/" /etc/driver-toolkit-release.json

  