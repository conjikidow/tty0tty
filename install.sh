#!/bin/bash

cd $(dirname $0)

cd module
make

sudo make modules_install

sudo usermod -a -G dialout ${USER}

sudo udevadm control --reload-rules
sudo depmod
sudo modprobe tty0tty
