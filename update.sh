#!/bin/bash

clear
echo
echo

echo -e "\e[1;34mUpdating Arch.\e[0m"
pacman -Syu ; pacman -Qdtq | pacman -Rs ; pacman -Scc  ; echo

if [ -d /opt/discover/.git ]; then
     echo -e "\e[1;34mUpdating Discover scripts.\e[0m"
     cd /opt/discover/ ; git pull ; echo
     cp /opt/discover/alias /root/.bash_aliases ; source /root/.bash_aliases
else
     rm -rf /opt/scripts/
     echo -e "\e[1;33mInstalling scripts into new location: /opt/discover/.\e[0m"
     git clone https://github.com/Oweoqi/discover.git /opt/discover
     echo
fi

if [ -d /opt/easy-creds/.git ]; then
     echo -e "\e[1;34mUpdating easy-creds.\e[0m"
     cd /opt/easy-creds/ ; git pull
     echo
else
     echo -e "\e[1;33mInstalling easy-creds.\e[0m"
     git clone git://github.com/brav0hax/easy-creds.git /opt/easy-creds
     ln -s /opt/easy-creds/easy-creds.sh  /usr/bin/easy-creds
     echo
fi

if [ ! -f /usr/bin/i586-mingw32msvc-c++ ]; then
     echo -e "\e[1;33mInstalling Ming C Compiler.\e[0m"
     pacman -S mingw32
     echo
fi

if [ ! -f /opt/google/chrome/google-chrome ]; then
     echo -e "\e[1;33mInstalling Google Chrome.\e[0m"
     wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
     dpkg -i google-chrome-stable_current_amd64.deb
     head -n -1 /opt/google/chrome/google-chrome > temp.txt ; mv temp.txt /opt/google/chrome/google-chrome
     echo 'exec -a "$0" "$HERE/chrome"  "$@" --user-data-dir' >> /opt/google/chrome/google-chrome
     chmod +x /opt/google/chrome/google-chrome
     rm google-chrome-stable_current_amd64.deb
     echo
fi

if [ -d /opt/smbexec/.git ]; then
     echo -e "\e[1;34mUpdating smbexec.\e[0m"
     cd /opt/smbexec/ ; git pull
     echo
else
     echo -e "\e[1;33mInstalling smbexec.\e[0m"
     git clone git://github.com/pentestgeek/smbexec-2.git /opt/smbexec
     ln -s /opt/smbexec/smbexec.rb  /usr/bin/smbexec
     echo
fi

if [ -d /opt/veil/.git ]; then
     echo -e "\e[1;33mInstalling Veil-Evasion suite.\e[0m"
     unlink /usr/bin/veil
     rm -rf /opt/veil
     pacman -S veil-evasion veil-catapult
     echo
fi

if [ ! -f /usr/share/windows-binaries/wce.exe ]; then
     echo -e "\e[1;33mInstalling Windows Credential Editor.\e[0m"
     wget http://www.ampliasecurity.com/research/wce_v1_4beta_universal.zip
     unzip wce_v1_4beta_universal.zip
     chmod 755 wce.exe
     mv wce.exe /usr/share/windows-binaries/
     rm Changelog LICENSE.txt README wce_v1_4beta_universal.zip
     echo
fi

echo -e "\e[1;34mUpdating locate database.\e[0m" ; updatedb

echo
echo
