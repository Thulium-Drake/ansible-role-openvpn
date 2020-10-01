[![Build Status](https://drone.element-networks.nl/api/badges/Ansible/role-openvpn/status.svg)](https://drone.element-networks.nl/Ansible/role-openvpn)

# Ansible role to install OpenVPN
This role provides a means to install an OpenVPN server on a Linux system (currently only tested on Debian)

The server will use a simple script to authenticate users using a password file.
It can also be configured to use a specified PAM file.

## Setup
Before setting this up, you need to arrange:

* An SSL server certificate for the server in /etc/ssl/openvpn/server.crt|key
* The CA certificate for that certificate in /etc/ssl/openvpn/ca.crt

Then you need to configure the server an Ansible playbook along the lines of the one in [playbooks](playbooks/)

## Adding users
To add a user, add a line to /etc/openvpn/private/passwd with the following information:

```
# user password (plaintext) expiration (YYYYmmdd)
myuser myverylongsupercomplexpasswordfrompwgen64 20191231
```

Once a user longs in, the script will check the password and the optional expiration date.
