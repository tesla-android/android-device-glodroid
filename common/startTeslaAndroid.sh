#!/system/bin/sh
/vendor/bin/lighttpd -f /vendor/tesla-android/lighttpd/lighttpd.conf
sleep 1
wm size 1378x1050
sleep 1
/system/bin/tesla-android-virtual-display
