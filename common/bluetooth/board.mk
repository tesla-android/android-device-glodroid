# SPDX-License-Identifier: Apache-2.0

# Some framework code requires this to enable BT
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_CUSTOM_BT_CONFIG := device/glodroid/common/bluetooth/vnd_rpi4.txt
DEVICE_MANIFEST_FILE += device/glodroid/common/bluetooth/android.hardware.bluetooth@1.0.xml