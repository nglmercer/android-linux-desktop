# android-linux-desktop
 Documentation and testing of programs, applications and uses of the Linux environment in Android using Termux, both for root users with chroot Linux (root) and proot Linux (noroot)
# Prerequisites

### Termux

Termux is a terminal emulator and Linux environment for Android.

### Termux:x11

Termux:x11 is a Termux package that provides a graphical environment for running X11 applications.
### Recommended

1. git for cloning projects or repositories ```pkg install git```
2. wget for downloading files ```pkg install wget```
3. nano for editing files ```pkg install nano```
## Installation

1. Download Termux from the [Termux GitHub repository](https://github.com/termux/termux-app) in releases download section (not playstore version) or download this apk in f-droid store.
2. Download Termux:x11 from the [Termux:x11 GitHub repository](https://github.com/termux/termux-x11) in releases download section. 
3. Install Termux and Termux:x11 on your Android device.
4. Open Termux and update Termux packages.
```
pkg update && pkg upgrade
```
5. install the following packages in Termux:
```
pkg install x11-repo
pkg install tur-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install xfce4
```
6. install wget and download the script file.
```
pkg install wget

wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/startxfce4_termux.sh

chmod +x startxfce4_termux.sh
```
7. run the script file.
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

## Termux:x11

Termux:x11 is a Termux package that provides a graphical environment for running X11 applications.

## Applications

There are many applications that you can run like vs code, Firefox, Chrome
and many more.
1. VS Code `pkg install code-oss`
2. Firefox `pkg install firefox`
3. Chrome `pkg install chromium`
4. LibreOffice `pkg install libreoffice-fresh`
5. Gimp `pkg install gimp`
6. VLC `pkg install vlc`
7. audacity `pkg install audacity`
8. mpv `pkg install mpv`
9. mplayer `pkg install mplayer`
10. obs `pkg install obs-studio`
11. code-server `pkg install code-server`
