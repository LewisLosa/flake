#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "run this script as root"
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
BOOT_PART="/dev/${BOOT_INPUT#/dev/}"
[ -b "$BOOT_PART" ] || { echo "partition not found: $BOOT_PART"; exit 1; }

read -p "root partition (ex: nvme0n1p2 or sda2): " ROOT_INPUT
ROOT_PART="/dev/${ROOT_INPUT#/dev/}"
[ -b "$ROOT_PART" ] || { echo "partition not found: $ROOT_PART"; exit 1; }

if [ "$BOOT_PART" = "$ROOT_PART" ]; then
  echo "boot and root partitions must be different"
  exit 1
fi

BOOT_DISK="$(lsblk -no PKNAME "$BOOT_PART")"
[ -n "$BOOT_DISK" ] || { echo "cannot determine disk for $BOOT_PART"; exit 1; }
BOOT_DISK="/dev/$BOOT_DISK"

BOOT_NUM="$(lsblk -no PARTNUM "$BOOT_PART")"
[ -n "$BOOT_NUM" ] || { echo "cannot determine partition number for $BOOT_PART"; exit 1; }

echo ""
echo "The installer will FORMAT:"
echo "  Disk: $BOOT_DISK"
echo "  Boot: $BOOT_PART"
echo "  Root: $ROOT_PART"
read -p "type 'yes' to continue: " CONFIRM
[ "$CONFIRM" = "yes" ] || { echo "aborted"; exit 0; }

umount -R /mnt 2>/dev/null || true

sgdisk -t "${BOOT_NUM}:EF00" "$BOOT_DISK"

mkfs.fat -F32 -n NIXOS-BOOT "$BOOT_PART"
mkfs.ext4 -F -L NIXOS-ROOT "$ROOT_PART"

mount "$ROOT_PART" /mnt
mount --mkdir "$BOOT_PART" /mnt/boot

echo ""
echo "NixOS partitions mounted successfully"
echo ""
echo "next steps:"
echo "nixos-install --no-root-passwd --root /mnt --flake github:lewislosa/flake#hostname"
