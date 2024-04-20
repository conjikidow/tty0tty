# tty0tty - linux null modem emulator

  The tty0tty directory tree is divided in:

  - **module** - linux kernel module null-modem
  - **pts** - null-modem using ptys (without handshake lines)


## Null modem pts (unix98):

  When run connect two pseudo-ttys and show the connection names:

  - (/dev/pts/1) <=> (/dev/pts/2)

  the connection is:

  - TX -> RX
  - RX <- TX


## Module:

  The module is tested in Linux kernel 6.2.0.

  When loaded, create 8 ttys interconnected:

  - /dev/tnt0  <=>  /dev/tnt1
  - /dev/tnt2  <=>  /dev/tnt3
  - /dev/tnt4  <=>  /dev/tnt5
  - /dev/tnt6  <=>  /dev/tnt7

  the connection is:

  - TX   ->  RX
  - RX   <-  TX
  - RTS  ->  CTS
  - CTS  <-  RTS
  - DSR  <-  DTR
  - CD   <-  DTR
  - DTR  ->  DSR
  - DTR  ->  CD


## Requirements:

  For building the module kernel-headers or kernel source are necessary.


## Installation:

  Download the tty0tty package from one of these sources:
  Clone the repo https://github.com/conjikidow/tty0tty.git

  ```
  $ git clone https://github.com/conjikidow/tty0tty.git
  $ cd tty0tty
  ```

  Run the installation script:

  ```
  $ ./install.sh
  ```

  You should see new serial ports in ```/dev/``` (```ls /dev/tnt*```)
  You can now access the serial ports as /dev/tnt0 (1,2,3,4 etc) Note that the consecutive ports are interconnected. For example, /dev/tnt0 and /dev/tnt1 are connected as if using a direct cable.

  Persisting across boot:

  edit the file /etc/modules (Debian) or /etc/modules.conf

  ```
  $ nano /etc/modules
  ```
  and add the following line:

  ```
  tty0tty
  ```

  Note that this method will not make the module persist over kernel updates so if you ever update your kernel, make sure you build tty0tty again repeat the process.


## Debian package

  In order to build the dkms Debian package

  ```
  sudo apt-get update && sudo apt-get install -y dh-make dkms build-essential
  debuild -uc -us
  ```
