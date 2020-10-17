#!/bin/bash
sudo yum -y update
sudo yum -y install epel-release
sudo yum clean all
sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
sudo setsebool -P antivirus_can_scan_system 1
sudo setsebool -P clamd_use_jit 1
sudo getsebool -a | grep antivirus
sudo sed -i -e "s/^Example/#Example/" /etc/clamd.d/scan.conf
sudo sed -i -e "s/^#LocalSocket /LocalSocket /" /etc/clamd.d/scan.conf
sudo freshclam
sudo systemctl start clamd@scan
sudo systemctl enable clamd@scan
sudo systemctl status clamd@scan
