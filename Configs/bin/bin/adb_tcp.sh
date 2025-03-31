#!/system/bin/sh
sudo setprop service.adb.tcp.port 5555
sudo stop adbd
sudo start adbd
