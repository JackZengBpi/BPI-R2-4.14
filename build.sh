#!/bin/bash
if [[ $UID -eq 0 ]];
then
  echo "do not run as root!"
  exit 1;
fi

if [[ -d drivers ]];
then
  action=$1
  LANG=C
  #git pull
  #git reset --hard v4.14
  export INSTALL_MOD_PATH=$(dirname $(pwd))/mod/;export ARCH=arm;export CROSS_COMPILE=arm-linux-gnueabihf-
  if [[ ! -z ${#INSTALL_MOD_PATH}  ]]; then
    rm -r $INSTALL_MOD_PATH/lib/modules
    #echo $INSTALL_MOD_PATH
  fi

  if [[ "$action" == "reset" ]];
  then
    git reset --hard v4.14
    action=importconfig
  fi

  if [[ "$action" == "update" ]];
  then
    git pull
  fi

  if [[ "$action" == "importconfig" ]];
  then
#    cp ../mt7623n_evb_bpi_defconfig arch/arm/configs/
#    make mt7623n_evb_bpi_defconfig
#    cp ../mt7623n_evb_ryderlee_defconfig arch/arm/configs/
#	make mt7623n_evb_ryderlee_defconfig
#    cp ../mt7623n_evb_fwu_defconfig arch/arm/configs/
	make mt7623n_evb_fwu_defconfig
  fi

  if [[ "$action" == "config" ]];
  then
    make menuconfig
  fi

  if [[ -z "$action" ]];
  then
 #   set -x
    exec 3> >(tee build.log)
#    make --debug && make modules_install
    make 2>&3 && make modules_install 2>&3
    ret=$?
#    set +x
    exec 3>&-
    if [[ $ret == 0 ]];
    then
      cat arch/arm/boot/zImage arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb > arch/arm/boot/zImage-dtb
      mkimage -A arm -O linux -T kernel -C none -a 80008000 -e 80008000 -n "Linux Kernel $(git describe --tags)" -d arch/arm/boot/zImage-dtb ./uImage
      read -p "Press [enter] to copy data to SD-Card..."
      if  [[ -d /media/$USER/BPI-BOOT ]];
      then
        cp ./uImage /media/$USER/BPI-BOOT/bananapi/bpi-r2/linux/uImage
        sudo cp -r ../mod/lib/modules /media/$USER/BPI-ROOT/lib/
        sync
      else
        echo "SD-Card not found!"
      fi
    fi
  fi
fi
