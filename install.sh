#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "run this script as root"
  exit 1
fi

if [ -e /etc/nixos ]; then
  echo "this script must be run from nixos live iso"
  exit 1
fi

if ! command -v nixos-install >/dev/null 2>&1; then
  echo "nixos-install not found"
  exit 1
fi

clear
echo "available partitions:"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,LABEL
echo ""

read -p "boot partition (ex: nvme0n1p1 or sda1): " BOOT_INPUT
BOOT_PART="${BOOT_INPUT#/dev/}"
BOOT_PART="/dev/$BOOT_PART"

[ -b "$BOOT_PART" ] || { echo "partition not found: $BOOT_PART"; exit 1; }

read -p "root partition (ex: nvme0n1p2 or sda2): " ROOT_INPUT
ROOT_PART="${ROOT_INPUT#/dev/}"
ROOT_PART="/dev/$ROOT_PART"

[ -b "$ROOT_PART" ] || { echo "partition not found: $ROOT_PART"; exit 1; }

if [ "$BOOT_PART" = "$ROOT_PART" ]; then
  echo "boot and root partitions must be different"
  exit 1
fi

echo ""
echo "The installer will FORMAT:"
echo "  Boot: $BOOT_PART"
echo "  Root: $ROOT_PART"
read -p "type 'yes' to continue: " CONFIRM

[ "$CONFIRM" = "yes" ] || { echo "aborted"; exit 0; }

umount -R /mnt 2>/dev/null || true

mkfs.fat -F32 -n NIXOS-BOOT "$BOOT_PART"
mkfs.ext4 -F -L NIXOS-ROOT "$ROOT_PART"

mount /dev/disk/by-label/NIXOS-ROOT /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/NIXOS-BOOT /mnt/boot

echo ""
echo "NixOS partitions mounted successfully"
echo ""
echo "next steps:"
echo "  nixos-install --no-root-passwd --root /mnt --flake github:lewislosa/flake#hostname"