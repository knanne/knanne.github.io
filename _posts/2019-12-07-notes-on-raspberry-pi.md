---
categories: [tinkering]
tags: [raspberry pi, linux, VPN, networking]
---

A quick compilation of notes on Raspberry Pi

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# (Headless) Rasbperry Pi Setup

1. Download [latest version of Raspbian (Lite)](https://www.raspberrypi.org/downloads/raspbian/) and flash it to an SD card. [docs on flashing](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)
2. Create empty `ssh` file and place it on boot partition. [docs on ssh](https://www.raspberrypi.org/documentation/remote-access/ssh/)
```cmd
C:\Users\Kain
>>> E:
E:\
>>> touch ssh
```
3. Create and fill out a `wpa_supplicant.conf` file and place it on boot partition using the copy (`cp`) command below. [docs on wifi config](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md)
```cmd
E:\
>>> cp C:\Users\Kain\Documents\RaspberryPi\wpa_supplicant.conf wpa_supplicant.conf
```
4. Connect Pi to Router via LAN, and connect power. Pi should boot and flash red power light, and green internet light.
5. Scan Network to identify IP address of PI, probably corresponding to "Raspberry Pi Foundation". If on Windows, can use [advanced-ip-scanner](https://www.advanced-ip-scanner.com/)
6. SSH into the PI's IP address using *u:* `pi` *p:* `raspberry`. If on Windows, can use [this program.](https://www.putty.org/)
7. Change the default password by running the command `passwd`. [docs on users](https://www.raspberrypi.org/documentation/linux/usage/users.md)

# Pi Config

- run `sudo raspi-config` to configure the PI. [docs on config](https://www.raspberrypi.org/documentation/configuration/raspi-config.md)

# Fix Pi to Static IP

Great answers to [the question here.](https://raspberrypi.stackexchange.com/questions/37920/how-do-i-set-up-networking-wifi-static-ip-address)

- Show IP address of PI with `ip -4 addr show | grep global`.
- Show IP address of router with `ip route | grep default | awk '{print $3}'`
- Edit the config file by running `sudo nano /etc/dhcpcd.conf`. [docs on nano](https://www.raspberrypi.org/documentation/linux/usage/text-editors.md)
- Enter the following essential information (there is a section in the template for this). One section for ethernet connection, and one for WLAN.
```
interface eth0
static ip_address=[YOUR PI IP ADDRESS]
static routers=[YOUR ROUTER IP ADDRESS]
static domain_name_servers=[YOUR ROUTER IP ADDRESS]
```
```
interface wlan0
static ip_address=[YOUR PI IP ADDRESS]
static routers=[YOUR ROUTER IP ADDRESS]
static domain_name_servers=[YOUR ROUTER IP ADDRESS]
```
- `Ctrl+X` to exit nano  
- Type `y` to save changes when prompted
- Hit Enter to confirm file for writing and complete exit
- Reboot the Pi with `sudo reboot`

# Setup OpenVPN Client

Using [PiVPN](http://www.pivpn.io/)  

1. SSH into your pi and install pivpn with `curl -L https://install.pivpn.io | bash`
2. You can confirm default settings for most options. When prompted, enter your own domain name. You can get a free one from [noip](https://www.noip.com/)
3. Check that the service is running `sudo service openvpn status`
4. Create a new client certificate by running `pivpn add` and giving it a password
5. Copy the certificate file from pi to the device you want to connect from. If on Windows, can use [filezilla](https://filezilla-project.org/)
7. Next, [configure your DDNS service on your router.](https://www.noip.com/support/knowledgebase/how-to-configure-ddns-in-router/) If you are using a two router setup (modem/router), do this on the router acting as a modem where the internet comes in first.
8. Lastly, [forward the OpenVPN service port on your router,](http://www.noip.com/support/knowledgebase/general-port-forwarding-guide/) the default port from piVPN is *1194*. If you are using a two router setup (modem/router) you may need to first forward traffic on that port to the second router, to then be forwarded to the pi.

Useful PiVPN commands:  
- List certificates with `pivpn list`
- Revoke a compromised certificate with `pivpn revoke`
- List connected clients with `pivpn -c`

* Note that the VPN server automatically starts after a reboot, so nothing is needed if power to the pi cuts out temporarily
