These instructions are taken from the [Arch Linux ARM install guide](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3) for the Raspberry Pi 3

1. Start fdisk to partition the SD card:

        fdisk /dev/sdX

2. At the fdisk prompt, delete old partitions and create a new one:
    - Type **o**. This will clear out any partitions on the drive.
    - Type **p** to list partitions. There should be no partitions
        left.
    - Type **n**, then **p** for primary, **1** for the first
        partition on the drive, press ENTER to accept the default first
        sector, then type **+100M** for the last sector.
    - Type **t**, then **c** to set the first partition to type W95
        FAT32 (LBA).
    - Type **n**, then **p** for primary, **2** for the second
        partition on the drive, and then press ENTER twice to accept the
        default first and last sector.
    - Write the partition table and exit by typing **w**.
3. Create and mount the FAT filesystem:

        mkfs.vfat /dev/sdX1
        mkdir boot
        mount /dev/sdX1 boot

4. Create and mount the ext4 filesystem:

        mkfs.ext4 /dev/sdX2
        mkdir root
        mount /dev/sdX2 root

5. Download and extract the root filesystem (as root, not via sudo):

        wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-3-latest.tar.gz
        bsdtar -xpf ArchLinuxARM-rpi-3-latest.tar.gz -C root
        sync

6. Move boot files to the first partition:

        mv root/boot/* boot

7. Unmount the two partitions:

        umount boot root

8. Insert the SD card into the Raspberry Pi, connect ethernet, and
    apply 5V power.
9. Use the serial console or SSH to the IP address given to the board
    by your router.
    - Login as the default user *alarm* with the password *alarm*.
    - The default root password is *root*.
10. Initialize the pacman keyring and populate the Arch Linux ARM
    [package signing](https://archlinuxarm.org/about/package-signing) keys:

        pacman-key --init
        pacman-key --populate archlinuxarm
