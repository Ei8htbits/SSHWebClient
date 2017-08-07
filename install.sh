#!/bin/bash
#Install script for https://github.com/Ei8htbits/SSHWebClient
#Also assisted by L0rd-KamS0 with the beautiful script. Cheers mate! - Ei8htbits
module_url="https://github.com/Ei8htbits/SSHWebClient/raw/master/setup-module.tar.gz"
install_dir="/tmp/Shellinabox_Install/"
setup_dir="/tmp/Shellinabox_Install/setup-module/"
Module_dir="/tmp/Shellinabox_Install/setup-module/SSHWebClient/"
Internal_Dest="/pineapple/modules/"
SD_dest="/sd/modules/"


function main () {

#Download Packages to install directory
echo -e "Creating install directory in $install_dir\n"
mkdir $install_dir
wget -P $install_dir $module_url

tar -xzvf $install_dir"setup-module.tar.gz" -C $install_dir

echo -e "Where do you want the module installed?\n"
echo -e "1 == SD"
echo -e "2 == Internal\n"

read Install_dest

if [ $Install_dest == "1"  ]; then
  module_install $SD_dest

elif [ $Install_dest == "2" ]; then
  module_install $Internal_Dest

else
  echo -e "Enter 1 or 2\n"
  main
fi




echo -e "Where do you want the dependencies installed? (shellinabox_2)\n"
echo -e "1 == SD"
echo -e "2 == Internal\n"

read Install_dest1

if [ $Install_dest1 == "1"  ]; then
  dependencies_install "1"

elif [ $Install_dest1 == "2" ]; then
  dependencies_install "2"

else
  echo -e "Enter 1 & 2\n"
  main

fi

}




function module_install () {

mv $Module_dir $1

}




function dependencies_install () {


  if [ $1 == "1"  ]; then
    touch /usr/lib/opkg/info/shellinabox.list
    touch /usr/lib/opkg/info/shellinabox.control
    opkg install $setup_dir"shellinabox_2.10-1_ar71xx.ipk -d sd"

  elif [ $Install_dest1 == "2" ]; then
    opkg install $setup_dir"shellinabox_2.10-1_ar71xx.ipk"

  else
    echo -e "Enter 1 & 2\n"
    main

  fi

echo -e "Installation complete\n"
echo -e "Cleaning up\n"
rm -r "/tmp/Shellinabox_Install/"
exit

}


main
