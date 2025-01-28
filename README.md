## Info
These images are build with Elemental's `--expandable` flag. This causes the images to behave as follows:
- Boot into recovery on first boot (selecting the normal boot in GRUB will cause an error)
- Recovery automatically:
  - creates system partitions for the linux install
  - copies itself (the linux install) to the system partitions
  - reboots into the normal system installation

## Running Build Images
The GitHub Actions workflow should produce an artifact for each image that is being build. These are zipped .raw images. You can flash them to a disk or sd card and just run them on bare metal. But alternatively you can also run the in QEMU with the following workflow:
- Download the Artifact for the OS you want to run
- Unzip the resulting zip.
- You should now have a .raw file.
- Run `qemu-img convert -O qcow2 <filename>.raw <filename>.qcow2`
- Run `qemu-img resize <filename>.qcow2 20G`
- You can now run QEMU with the resulting qcow2 file as a disk. Below is an example to run a ubuntu aarch64 image on macos:
```bash
qemu-system-aarch64 \
    -M accel=hvf \
    -cpu host \
    -smp 4 \
    -m 4096 \
    -bios /opt/homebrew/Cellar/qemu/9.1.1/share/qemu/edk2-aarch64-code.fd \
    -serial stdio \
    -machine virt \
    -drive if=virtio,file=ubuntu.qcow2,format=qcow2
``` 

## Debugging in recovery mode
Elemental has some services that provide logs that could be helpful if an image does not auto-install from recovery.

```
elemental-setup-initramfs.service
elemental-rootfs.service
elemental-setup-rootfs.service
elemental-setup-pre-rootfs.service

elemental-setup-fs.service
elemental-setup-boot.service

elemental-setup-reconcile.service
elemental-setup-network.service
```

their logs can be viewed by running

```bash
journalctl -u <service-name>
```

from experience most disk related issues occur in the `elemental-setup-rootfs.service`, `elemental-setup-fs.service` and `elemental-setup-boot.service` and can be viewed by running
```bash
journalctl -u elemental-setup-rootfs.service
```
