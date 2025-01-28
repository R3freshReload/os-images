#!/bin/bash
qemu-system-aarch64 \
    -M accel=hvf \
    -cpu host \
    -smp 4 \
    -m 4096 \
    -bios /opt/homebrew/Cellar/qemu/9.1.1/share/qemu/edk2-aarch64-code.fd \
    -serial stdio \
    -machine virt \
    -drive file=build/ubuntu.qcow2,format=qcow2
