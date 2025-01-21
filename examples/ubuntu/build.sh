#!/bin/bash
set -eux
docker build -t example-ubuntu-os .
docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock --entrypoint /bin/sh -v $(pwd)/build:/output ghcr.io/rancher/elemental-toolkit/elemental-cli:v2.2.0 -c "elemental build-disk --squash-no-compression --system example-ubuntu-os --config-dir /config --local --output /build --expandable --debug -n ubuntu && mv /build/ubuntu.raw /output/"
qemu-img convert -O qcow2 build/ubuntu.raw build/ubuntu.qcow2 
qemu-img resize build/ubuntu.qcow2 20G 