#!/system/bin/sh
/vendor/bin/lighttpd -f /vendor/tesla-android/lighttpd/lighttpd.conf
sleep 1
/vendor/bin/v4l2-ctl --set-edid=file=/vendor/tesla-android/edid.txt 
sleep 1
/vendor/bin/v4l2-ctl --set-dv-bt-timings query
sleep 1
/system/bin/mjpg_streamer -o 'output_http.so -p 9090' -i 'input_uvc.so -d /dev/video0 -uyvy -q 75 -dv_timings -timeout 5'