FROM ghcr.io/rancher/elemental-toolkit/elemental-cli:v2.2.0 AS toolkit

FROM registry.opensuse.org/opensuse/tumbleweed:latest as OS
ARG REPO
ARG VERSION
ENV VERSION=${VERSION}

# install kernel, systemd, dracut, grub2 and other required tools
RUN zypper --non-interactive install --no-recommends -- \
      kernel-default \
      device-mapper \
      dracut \
      grub2 \
      grub2-arm64-efi \
      raspberrypi-firmware \
      raspberrypi-firmware-config \
      raspberrypi-firmware-dt \
      u-boot-rpiarm64 \
      shim \
      haveged \
      systemd \
      NetworkManager \
      openssh-server \
      openssh-clients \
      timezone \
      parted \
      e2fsprogs \
      dosfstools \
      mtools \
      xorriso \
      findutils \
      gptfdisk \
      rsync \
      squashfs \
      lvm2 \
      tar \
      gzip \
      vim \
      which \
      less \
      sudo \
      curl \
      podman \
      sed && \
    zypper clean --all

# Just add the elemental cli
COPY --from=TOOLKIT /usr/bin/elemental /usr/bin/elemental

# Enable essential services
RUN systemctl enable NetworkManager.service

# Generate initrd with required elemental services
RUN elemental init -f && \
    kernel=$(ls /boot/Image-* | head -n1) && \
    if [ -e "$kernel" ]; then ln -sf "${kernel#/boot/}" /boot/vmlinuz; fi && \
    rm -rf /var/log/update* && \
    >/var/log/lastlog && \
    rm -rf /boot/vmlinux*

# Update os-release file with some metadata
RUN echo IMAGE_REPO=\"${REPO}\"         >> /etc/os-release && \
    echo IMAGE_TAG=\"${VERSION}\"           >> /etc/os-release && \
    echo IMAGE=\"${REPO}:${VERSION}\" >> /etc/os-release && \
    echo TIMESTAMP="date +'%Y%m%d%H%M%S'" >> /etc/os-release && \
    echo GRUB_ENTRY_NAME=\"Elemental\" >> /etc/os-release


# Good for validation after the build
CMD /bin/bash
