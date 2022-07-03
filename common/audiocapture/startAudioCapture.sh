#!/system/bin/sh

appops set eu.gapinski.teslaandroid.audiocapture PROJECT_MEDIA allow
pm grant eu.gapinski.teslaandroid.audiocapture android.permission.RECORD_AUDIO
pm grant eu.gapinski.teslaandroid.audiocapture android.permission.FOREGROUND_SERVICE
pm grant eu.gapinski.teslaandroid.audiocapture android.permission.INTERNET

am start eu.gapinski.teslaandroid.audiocapture/.MainActivity