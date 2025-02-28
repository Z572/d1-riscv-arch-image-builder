#!/usr/bin/sh
export CROSS_COMPILE='riscv64-linux-gnu-'
export ARCH='riscv'
PWD="$(pwd)"
NPROC="$(nproc)"
export PWD
export NPROC

export ROOT_FS='archriscv-2023-05-02.tar.zst'
export ROOT_FS_DL="https://archriscv.felixc.at/images/${ROOT_FS}"

# select 'arch', 'defconfig'
export KERNEL='defconfig'

# Device Tree:
# In the current pinned U-Boot Commit the following device trees are available
# for the D1:
# u-boot/arch/riscv/dts/sun20i-d1-lichee-rv-86-panel.dtb
# u-boot/arch/riscv/dts/sun20i-d1-lichee-rv-dock.dtb
# u-boot/arch/riscv/dts/sun20i-d1-lichee-rv.dtb
# u-boot/arch/riscv/dts/sun20i-d1-mangopi-mq-pro.dts
# u-boot/arch/riscv/dts/sun20i-d1-nezha.dtb
export DTB=u-boot/arch/riscv/dts/sun20i-d1-lichee-rv-dock.dtb

# folder to mount rootfs
export MNT='mnt'
# folder to store compiled artifacts
export OUT_DIR="${PWD}/output"

# run as root
export SUDO='sudo'

# use arch-chroot?
export USE_CHROOT=1

# use extlinux ('extlinux') or boot.scr ('script') for loading the kernel?
export BOOT_METHOD='extlinux'

export VERSION_OPENSBI='1.2'

export SOURCE_OPENSBI="https://github.com/riscv-software-src/opensbi/releases/download/v${VERSION_OPENSBI}/opensbi-${VERSION_OPENSBI}-rv-bin.tar.xz"
export SOURCE_UBOOT='https://github.com/smaeul/u-boot'
export SOURCE_KERNEL='https://github.com/torvalds/linux.git'
export SOURCE_RTL8723='https://github.com/lwfinger/rtl8723ds.git'
# https://github.com/karabek/xradio

# pinned commits (no notice when things change)
# export COMMIT_UBOOT='afc07cec423f17ebb4448a19435292ddacf19c9b' # equals d1-2022-05-26
# export TAG_UBOOT='d1-2022-05-26'
export COMMIT_UBOOT='329e94f16ff84f9cf9341f8dfdff7af1b1e6ee9a' # equals d1-2022-10-31
export TAG_UBOOT='d1-2022-10-31'
export COMMIT_KERNEL='457391b0380335d5e9a5babdec90ac53928b23b4' # equals v6.3
export TAG_KERNEL='v6.3'
# use this (set to something != 0) to override the check
export IGNORE_COMMITS=0
export DEBUG='n'

check_deps() {
    if ! pacman -Qi "${1}" >/dev/null; then
        echo "Please install '${1}'"
        exit 1
    fi
}

if [ -n "${CI_BUILD}" ]; then
    export USE_CHROOT=0
fi
