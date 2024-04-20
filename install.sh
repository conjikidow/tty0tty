#!/bin/bash

module_name="tty0tty"


cd $(dirname $0)

cd module
make

sudo make modules_install

sudo usermod -a -G dialout ${USER}

sudo udevadm control --reload-rules
sudo depmod
sudo modprobe $module_name

ls /dev/tnt*


modules_file="/etc/modules"

if ! sudo grep -q "^$module_name$" "$modules_file"; then
    sudo sh -c "echo \"$module_name\" >> \"$modules_file\""
fi
