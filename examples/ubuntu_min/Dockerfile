FROM ghcr.io/r3freshreload/os-images/ubuntu-os

# Do some modifications
RUN apt update && apt install -y kde-plasma-desktop

# We have to re run this after changing the image!
RUN ARCH=$(uname -m); \
    if [[ "${ARCH}" != "x86_64" ]]; then \
      FEATURES="autologin boot-assessment cloud-config-defaults cloud-config-essentials dracut-config elemental-rootfs elemental-setup elemental-sysroot grub-config"; \
      [[ "${ARCH}" == "aarch64" ]] && FEATURES+=" arm-firmware grub-default-bootargs"; \
    fi; \
    elemental --debug init --force ${FEATURES}