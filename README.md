# NixOS-Dots

![NixOS White Logo](./.github/assets/nixos-white.png)

---

Configuration files for my NixOS setup

## Installation

1. Download and format a fresh copy of NixOS (preferably the latest version) ISO file

```sh
sudo cp nixos.iso /dev/sdX
sudo dd if=nixos.iso of=/dev/sdX bs=4M status=progress conv=fdatasync
```

> [!NOTE]
> Replace `nixos.iso` with your NixOS installation file.
> Replace `/dev/sdX` with the right boot device (can be found with `lsblk` or `sudo fdisk -l`)

