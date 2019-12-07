---
categories: [android]
tags: [android, google, nexus, fastboot, adb]
---

Random notes on interfacing with and updating an Android phone via command line  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Android SDK

Get the Android SDK, you really only need the `adb` [platform-tools](https://developer.android.com/studio/releases/platform-tools.html).  

# Android USB Debugging

1. Access Developer Options
2. Enable USB Debugging
3. Change USB options from charging to some file transfer option (PTP or MTP)
4. Run command prompt in Administrator Mode
5. Navigate to ADB `platform-tools` and run `adb devices` (this will run ADB server if not already running)
    - this should show the device, if not see special instructions below
6. Type `adb reboot bootloader` to boot phone into fastboot mode (same as holding down power and volume down)  
7. Type `fastboot devices` to confirm device still available

*[Special instructions to get ADB working with latest Windows versions and Intel drivers](https://software.intel.com/en-us/xdk/docs/configuring-your-windows-usb-android-debug-connection-for-the-intel-xdk)*  

*You most likely need to download device-specific drivers from OEM site  as well.*  

# Recovery

You will need a recovery to be able to install custom software. The most popular choices being [ClockworkMod (CWM)](https://www.clockworkmod.com/) or [TeamWin Recovery Project (TWRP)](https://twrp.me/).

The rest of the examples given below are from the context of using TWRP.  

### Install Recovery

1. Go into Fastboot Mode with `adb reboot bootloader` or holding power and volume down
2. `fastboot flash recovery PATH-TO-LOCAL-FILE.img`
3. `fastboot reboot bootloader`
4. Select "Reboot Recovery" from options (using volume down for menu and power to select)

# Cases

### Copy to PC for Backing Up

1. Reboot into Recovery
2. Select "Backup" > swipe to backup
3. from PC, run `adb pull /sdcard/TRWP/`, this will copy the entire TWRP directory with all backups

### Copy to Device for Flashing

1. Reboot into recovery  
2. `adb push PATH-TO-LOCAL-FILE.zip /sdcard/`
3. Select "Install", find file, and swipe to install

### Flash Directly from PC

1. Reboot into Recovery
2. (TRWP) Select "Advanced" > "ADB Sideload"
3. from PC, run `adb sideload PATH-TO-LOCAL-FILE.zip`

source: [https://twrp.me/faq/ADBSideload.html](https://twrp.me/faq/ADBSideload.html)

### No OS?

Here is some helpful advice from TWRP [https://twrp.me/faq/noos.html](https://twrp.me/faq/noos.html)  

# Stories

### Flash ROM With Encryption Issue

I had an issue with the latest version of multiple ROMS being stuck in bootloop after a CLEAN install. The issue seemed to be due to encryption of the internal storage, standard in new Android versions with lockscreen lock, and the new ROM not being able to decrypt during boot. The solution was to reformat the internal storage and do a fresh install by sideloading the ROM.  

1. Reboot Recovery
2. Format Data
3. Reboot Recovery
4. ADB Sideload latest version
5. Reboot Recovery

### Google Device Factory Reset

I recently needed to restore my Nexus 5x back to factory settings. Below are my notes on how I did this.  

Get [stock images from Google](https://developers.google.com/android/images).  

Boot into Fastboot. Refer to instructions on [how to boot into fastboot mode](https://source.android.com/source/running.html#booting-into-fastboot-mode).  

Check for device:  

```shell
fastboot devices
```

Flash factory images like this:  

```shell
fastboot flash bootloader C:\bullhead\images\bootloader-bullhead-bullhead-xx.xx.img
fastboot reboot-bootloader
fastboot flash radio C:\bullhead\images\radio-bullhead-bullhead-xx.xx.img
fastboot reboot-bootloader
fastboot flash boot C:\bullhead\images\boot.img
fastboot erase cache
fastboot flash cache C:\bullhead\images\cache.img
fastboot flash recovery C:\bullhead\images\recovery.img
fastboot flash system C:\bullhead\images\system.img
fastboot flash vendor C:\bullhead\images\vendor.img
```
[source](https://forum.xda-developers.com/nexus-5x/general/guides-how-to-guides-beginners-t3206930)  

# Random Notes

## XDA

Search your device on [XDA](https://forum.xda-developers.com/) and just start reading.  

## TWRP

Personally recommended [Team Win Recovery Project (TWRP)](https://twrp.me/) is a custom recovery you probably need  

Find your device, download, and `fastboot flash recovery twrp.img`  

## ROM

Personally recommended custom ROMS  

- [OmniROM](https://www.omnirom.org/)
- [Lineage OS](https://download.lineageos.org/)
- [Pixel Eperience](https://download.pixelexperience.org/)

## GApps

Community standard [Open GApps](http://opengapps.org/)  

Flash in recovery  

# Fastboot Commands

find device, not in fastboot mode  

```shell
adb devices
```

reboot into fastboot mode  

```shell
adb reboot-bootloader
```

push file from pc to device  

```shell
adb push <LOCAL> <REMOTE>
```

pull file from device to pc  

```shell
adb pull <REMOTE> <LOCAL>
```

wipe user data and cache  

```shell
fastboot -w
```

wipe system, user data, and cache  

```shell
fastboot erase system -w
```
