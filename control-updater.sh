#!/bin/sh

NAME="frp"
DIR=`pwd`

apply_version(){
    sed -i "s/\[VERSION\]/$VERSION/g" $DIR/DEBIAN/control
}

apply_architecture(){
    sed -i "s/\[ARCH\]/$ARCH/g" $DIR/DEBIAN/control
}

main(){
    read -p "Please enter $NAME version: " VERSION
    read -p "Please enter architecture name: " ARCH
    apply_version
    apply_architecture
    echo "Control file applied!" && exit 0
}

main
