# android-linux-desktop
 Documentation and testing of programs, applications and uses of the Linux environment in Android using Termux, both for root users with chroot Linux (root) and proot Linux (noroot)
## Prerequisites
1. Download Termux from the [Termux GitHub repository](https://github.com/termux/termux-app) in releases download section (not playstore version) or download this apk in f-droid store.
2. Download Termux:x11 from the [Termux:x11 GitHub repository](https://github.com/termux/termux-x11) in releases download section. 
3. Install Termux and Termux:x11 on your Android device.
### Termux

Termux is a terminal emulator and Linux environment for Android.

### Termux:x11

Termux:x11 is a Termux package that provides a graphical environment for running X11 applications.

### Recommended

1. git for cloning projects or repositories ```pkg install git```
2. wget for downloading files ```pkg install wget```
3. nano for editing files ```pkg install nano```
## Installation Native Termux Desktop

1. Open Termux and update Termux packages.
```
pkg update && pkg upgrade
```
2. install the following packages in Termux:
```
pkg install x11-repo
pkg install tur-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install xfce4
```
3. install wget and download the script file.
```
pkg install wget

wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/startxfce4_termux.sh

chmod +x startxfce4_termux.sh
```
4. run the script file.
```
./startxfce4_termux.sh
```
### If you need to install everything without having to write anything else
- copy and paste this script: 
```
pkg update -y
pkg upgrade -y
pkg install x11-repo -y
pkg install tur-repo -y
pkg install termux-x11-nightly -y
pkg install pulseaudio -y
pkg install xfce4 -y
pkg install wget -y
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/startxfce4_termux.sh
chmod +x startxfce4_termux.sh
./startxfce4_termux.sh
```
### Execution
- execute the script file
```
./startxfce4_termux.sh
```
### If Termux X11 randomly getting killed/shutdown
- execute with adb shell
```
adb shell "/system/bin/device_config set_sync_disabled_for_tests persistent"
adb shell "/system/bin/device_config put activity_manager max_phantom_processes 2147483647"
adb shell settings put global settings_enable_monitor_phantom_procs false
```
### credits and more information
this documentation is based on the following documentation:
- https://github.com/LinuxDroidMaster/Termux-Desktops
#### especially the following documentation:
- https://github.com/LinuxDroidMaster/Termux-Desktops/blob/main/Documentation/native/termux_native.md
## Applications in Native Termux Desktop

There are many applications that you can run like vs code, Firefox, Chrome
and many more.
1. VS Code `pkg install code-oss` [x] tested and working
2. Firefox `pkg install firefox` [x] tested and working
3. Chrome `pkg install chromium` [x] tested and working
5. Gimp `pkg install gimp` [x] tested and working
6. VLC `pkg install vlc` [] no open in my device
7. audacity `pkg install audacity` [x] tested and working
8. blender `pkg install blender` [x] tested and working
9. kdenlive `pkg install kdenlive` [x] tested and working
10. godot `pkg install godot` [x] tested and working but is very slow
17. code-server `pkg install code-server` [x] tested and working
18. mpv `pkg install mpv` [x] tested and working in terminal
19. mplayer `pkg install mplayer` [x] tested and working in terminal
## Installation Chroot Linux Desktop
### Pre-requisites
- Root access(recommend magisk manager)
- Busybox installed [busybox github](https://github.com/Magisk-Modules-Alt-Repo/BuiltIn-BusyBox)

### Installation
1. Open Termux and update Termux packages.
```
pkg update && pkg upgrade
```
2. install the following packages in Termux:
```
pkg install x11-repo
pkg install tur-repo
pkg install root-repo
pkg install termux-x11-nightly  
pkg install pulseaudio
pkg install xfce4
pkg install tsu
```
3.💻Download Debian chroot - automatic installer 
```
wget https://raw.githubusercontent.com/nglmercer/android-linux-desktop/main/scripts/chroot/chroot_debian_installer.sh
chmod +x chroot_debian_installer.sh
su
sh chroot_debian_installer.sh
```
link alternatively:
```
wget https://raw.githubusercontent.com/nglmercer/android-linux-desktop/main/scripts/chroot/chroot_debian_installer.sh
```
4. follow the instructions
5. run the script file.
```
wget https://raw.githubusercontent.com/nglmercer/android-linux-desktop/main/scripts/chroot/startxfce4_chrootDebian.sh
chmod +x startxfce4_chrootDebian.sh
./startxfce4_chrootDebian.sh
```
### If you need to install everything without having to write anything else
- copy and paste this script: 
```
pkg update -y
pkg upgrade -y
pkg install x11-repo -y
pkg install tur-repo -y
pkg install root-repo -y
pkg install termux-x11-nightly -y
pkg install pulseaudio -y
pkg install xfce4 -y
pkg install tsu -y
wget https://raw.githubusercontent.com/nglmercer/android-linux-desktop/main/scripts/chroot/chroot_debian_installer.sh
chmod +x chroot_debian_installer.sh
su
sh chroot_debian_installer.sh
wget https://raw.githubusercontent.com/nglmercer/android-linux-desktop/main/scripts/chroot/startxfce4_chrootDebian.sh
chmod +x startxfce4_chrootDebian.sh
./startxfce4_chrootDebian.sh
```
### Execution
- execute the script file
```
./startxfce4_chrootDebian.sh
```
## Applications in Chroot Linux Desktop

There are many applications that you can run like vs code, Firefox, Chrome
and many more.