#!/bin/bash
#
# Script name	: sploit-dev.sh
# Author	: wetw0rk
# Ubuntu Ver.	: Ubuntu 17.04
# How2Run	: chmod +x sploit-dev.sh && sudo ./sploit-dev.sh
# Last updated	: 6/5/2017
# Description	: Simply installs the metasploit framework aswell as
#		  gdb-peda used for finding offsets :)
#
# Sources	:
#	https://help.rapid7.com/metasploit/Content/installation-and-updates/installing-msf.html
#

# Colors
YELLOW="\033[01;33m"
BLUE="\033[01;34m"
RESET="\033[00m"


echo -e "${BLUE}[*] Installing Git${RESET}"
sudo apt-get install git
echo -e "${BLUE}[*] Installing msfconsole${RESET}"
sudo curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
echo -e "${BLUE}[*] Removing msfinstall script${RESET}"
rm msfinstall
echo -e "${BLUE}[*] Installing GDB-PEDA${RESET}"
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit
