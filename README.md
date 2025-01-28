## Info
These images are build with Elemental's `--expandable` flag. This causes the images to behave as follows:
- Boot into recovery on first boot (selecting the normal boot in GRUB will cause an error)
- Recovery automatically:
  - creates system partitions for the linux install
  - copies itself (the linux install) to the system partitions
  - reboots into the normal system installation

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