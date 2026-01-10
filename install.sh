#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "run this script as root"
  exit 1
fi

if [ ! -e /etc/NIXOS ] && ! command -v nixos-install >/dev/null 2>&1; then
  echo "this script only works on nixos live iso"
  exit 1
fi

clear
echo "available partitions:"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,LABEL | grep part || true
echo ""

read -p "boot partition (ex: nvme0n1p1 or sda1, you can include /dev/): " BOOT_INPUT
if [[ "$BOOT_INPUT" == /* ]]; then
  BOOT_PART="$BOOT_INPUT"
else
  BOOT_PART="/dev/${BOOT_INPUT}"
fi

if [ ! -b "$BOOT_PART" ]; then
  echo "partition not found: $BOOT_PART"
  exit 1
fi

read -p "root partition (ex: nvme0n1p2 or sda2, you can include /dev/): " ROOT_INPUT
if [[ "$ROOT_INPUT" == /* ]]; then
  ROOT_PART="$ROOT_INPUT"
else
  ROOT_PART="/dev/${ROOT_INPUT}"
fi

if [ ! -b "$ROOT_PART" ]; then
  echo "partition not found: $ROOT_PART"
  exit 1
fi

if [ "$BOOT_PART" = "$ROOT_PART" ]; then
  echo "boot and root partitions must be different"
  exit 1
fi

echo ""
echo "The installer will FORMAT the selected partitions:" 
echo "  Boot: $BOOT_PART"
echo "  Root: $ROOT_PART"
read -p "type 'yes' to continue: " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
  echo "aborted"
  exit 0
fi

echo ""
echo "Formatting and mounting selected partitions..."

umount -R /mnt 2>/dev/null || true

mkfs.fat -F32 -n boot "$BOOT_PART"
mkfs.ext4 -F -L nixos-root "$ROOT_PART"

mount "$ROOT_PART" /mnt
mkdir -p /mnt/boot
mount "$BOOT_PART" /mnt/boot

mount /dev/disk/by-label/nixos-root /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/nixos-boot /mnt/boot

echo ""
echo "NixOS is ready for installation on $DISK"
echo "yippee~~!"
echo ""
echo "next steps:"
echo "  sudo nixos-install --no-root-passwd --root /mnt --flake github:lewislosa/flake#hostname"