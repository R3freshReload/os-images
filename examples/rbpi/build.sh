#!/bin/bash
set -eux

docker build -t example-rbpi-os .
docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock --entrypoint /bin/sh -v $(pwd)/build:/output ghcr.io/rancher/elemental-toolkit/elemental-cli:v2.2.0 -c "elemental build-disk --squash-no-compression --system example-rbpi-os --config-dir /config --local --output /build --expandable --debug -n rbpi && mv /build/rbpi.raw /output/"
qemu-img convert -O qcow2 build/rbpi.raw build/rbpi.qcow2 
qemu-img resize build/rbpi.qcow2 20G 
