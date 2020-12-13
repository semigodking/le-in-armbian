#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 image_url_or_path"
  exit -1
fi

url=$1
archivename="${url##*/}"
ext='gz'
filename=`basename ${archivename} .$ext`

# Check file exists
file_exists=0
if [ -e "${url}" ]; then
  archivename=$url
  filename="$(dirname ${url})/$(basename ${url})"
  file_exists=1
else
  if [ -e "${archivename}" ]
  then
    echo "Already have the image file: $archivename"
    file_exists=1
  else
    if [ -e "${filename}" ]
    then
      echo "$filename exists.  Not downloading $url."
      file_exists=1
    else
      echo "Retrieving $url .."
      wget --show-progress --progress=bar:force:noscroll $url
      if [ $? -ne 0 ]; then
        file_exists=1
      fi
    fi
  fi
fi

if [[ file_exists -eq 0 ]]; then
  exit -1
fi

if [ -e "${filename}" ]
then
  echo "Already extracted to: $filename"
else
  echo "Extracting $filename .."
  if [ $ext == "gz" ]; then
    gzip -d "${archivename}"
  elif [ $ext == "xz" ]; then
    xz -d "${archivename}"
  fi
fi

declare -i start_sector
start_sector=$(/sbin/fdisk -l ./${filename} | awk -F" "  '{ print $3 }' | tail -n1)
(( start_offset = $start_sector * 512 ))

mkdir -p img-mount
(sudo umount img-mount || /bin/true)

if ! (sudo mount -o loop,offset=$start_offset ./${filename} ./img-mount); then    
    echo "mount failed, trying a different partition"
    mkdir -p sys-mount
    start_sector=$(/sbin/fdisk -l ./${filename} | awk -F" "  '{ print $3 }' | tail -n2 | head -n1)
    (( start_offset = $start_sector * 512 ))
    if ! (sudo mount -o loop,offset=$start_offset ./${filename} ./sys-mount); then
       echo "unable to mount.  error."
       exit
    else
      if ! (sudo mount -o loop ./sys-mount/SYSTEM ./img-mount); then
        echo "unable to find an image within the image."
        exit
      else
        echo "SYSTEM mounted"
        ls img-mount
      fi
    fi
fi

mkdir rootfs
sudo rsync -axHAX --info=progress2 img-mount/ rootfs/

sudo umount ./img-mount
rmdir ./img-mount

sudo umount ./sys-mount
rmdir ./sys-mount

echo "$url extracted to rootfs/"

# Customize ROOTFS
cp start_kodi.sh rootfs/
cd rootfs/ && ln -s /run /var/run
mkdir -p rootfs/run/dbus
mkdir -p rootfs/home/kodi
# cleanup
#rm "${filename}"
#rm "${archivename}"
# sudo mount -o loop,offset=16777216 ./LibreELEC-RK3399.arm-9.1-nightly-20190324-5ccaa74-rockpro64.img ./img-mount
