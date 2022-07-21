FROM k8s.gcr.io/scl-image-builder/cluster-node-image-builder-amd64:v0.1.12

USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y qemu qemu-kvm

USER imagebuilder
