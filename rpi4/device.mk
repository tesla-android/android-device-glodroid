# SPDX-License-Identifier: Apache-2.0
#
# Copyright (C) 2020 Roman Stratiienko (r.stratiienko@gmail.com)

$(call inherit-product, device/glodroid/common/device-common.mk)
$(call inherit-product, device/glodroid/common/bluetooth/bluetooth.mk)
$(call inherit-product, vendor/brcm/rpi4/rpi4-vendor.mk)

# Firmware
PRODUCT_COPY_FILES += \
        vendor/raspberry/firmware-nonfree/brcm/brcmfmac43455-sdio.clm_blob:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/brcmfmac43455-sdio.clm_blob \
        vendor/raspberry/firmware-nonfree/brcm/brcmfmac43455-sdio.bin:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/brcmfmac43455-sdio.bin \
        vendor/raspberry/firmware-nonfree/brcm/brcmfmac43455-sdio.txt:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/brcmfmac43455-sdio.txt \
        vendor/raspberry/firmware-nonfree/brcm/brcmfmac43456-sdio.clm_blob:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/brcmfmac43456-sdio.clm_blob \
        vendor/raspberry/firmware-nonfree/brcm/brcmfmac43456-sdio.bin:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/brcmfmac43456-sdio.bin \
        vendor/raspberry/firmware-nonfree/brcm/brcmfmac43456-sdio.txt:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/brcmfmac43456-sdio.txt \
        device/glodroid/rpi4/BCM4345C0.hcd:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/BCM4345C0.hcd \
        device/glodroid/rpi4/BCM4345C5.hcd:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/BCM4345C5.hcd \

PRODUCT_COPY_FILES += \
    device/glodroid/rpi4/audio.rpi4.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio.rpi4.xml \

# Disable suspend. During running some VTS device suspends, which sometimed causes kernel to crash in WIFI driver and reboot.
PRODUCT_COPY_FILES += \
    device/glodroid/common/no_suspend.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/no_suspend.rpi4.rc \

# Checked by android.opengl.cts.OpenGlEsVersionTest#testOpenGlEsVersion. Required to run correct set of dEQP tests.
# 196609 == 0x00030001 == GLES v3.1
PRODUCT_VENDOR_PROPERTIES += \
    ro.opengles.version=196609

# Vulkan
PRODUCT_PACKAGES += \
    vulkan.broadcom

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml \

PRODUCT_VENDOR_PROPERTIES +=    \
    ro.hardware.vulkan=broadcom \

PRODUCT_CHARACTERISTICS := tablet

# It is the only way to set ro.hwui.use_vulkan=true
#TARGET_USES_VULKAN = true
