#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable userspace reboot
$(call inherit-product, $(SRC_TARGET_DIR)/product/userspace_reboot.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Enable Scoped Storage related
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

ifneq (,$(filter $(DEVICE_TYPE),tv))
# Setup TV Build
USE_OEM_TV_APP := true
$(call inherit-product, device/google/atv/products/atv_base.mk)
PRODUCT_CHARACTERISTICS := tv
PRODUCT_AAPT_PREF_CONFIG := tvdpi
PRODUCT_IS_ATV := true
else

ifeq (,$(filter $(GLODROID_LOWRAM),))
# Adjust the dalvik heap to be appropriate for a tablet.
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)
endif
endif

PRODUCT_SHIPPING_API_LEVEL := 31

# Add wifi-related packages
PRODUCT_PACKAGES += libwpa_client wpa_supplicant hostapd wificond
PRODUCT_PROPERTY_OVERRIDES += wifi.interface=wlan0 \
                              wifi.supplicant_scan_interval=15

# Build and run only ART
PRODUCT_RUNTIMES := runtime_libart_default

# Audio
# Build default bluetooth a2dp and usb audio HALs
PRODUCT_PACKAGES += audio.usb.default \
		    audio.r_submix.default \
		    tinyplay

PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@6.0-impl \
    android.hardware.audio.effect@6.0-impl \

PRODUCT_COPY_FILES += \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \

PRODUCT_PACKAGES += \
    tinyalsa tinymix tinycap tinypcminfo \
    audio.primary.$(TARGET_PRODUCT) \

PRODUCT_PACKAGES += \
    android.hardware.drm@1.3-service.clearkey \

PRODUCT_PACKAGES += libGLES_android

PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.0-service \

# Create input surface on the framework side
PRODUCT_VENDOR_PROPERTIES += \
    debug.stagefright.c2inputsurface=-1 \

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.1-impl-mock \

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service \

# Thermal HAL
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service.mock \

# OpenGL driver
PRODUCT_PACKAGES += \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libglapi \

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml

# Composer passthrough HAL
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.4-impl \
    android.hardware.graphics.composer@2.4-service \

## Composer HAL for gralloc4 + minigbm gralloc4
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-service.minigbm_gbm_mesa \
    android.hardware.graphics.mapper@4.0-impl.minigbm_gbm_mesa \
    hwcomposer.drm \

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.hwcomposer=drm \
##

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=180 \

# Gatekeeper HAL
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software \

# Keymint HAL
PRODUCT_PACKAGES += \
    android.hardware.security.keymint-service

# PowerHAL
PRODUCT_PACKAGES += \
    android.hardware.power-service.example \

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl \

ifneq (,$(filter $(DEVICE_TYPE),tv))
# TV Specific Packages
PRODUCT_PACKAGES += \
    TvSettings \
    LiveTv \
    google-tv-pairing-protocol \
    TvProvision \
    LeanbackSampleApp \
    TvSampleLeanbackLauncher \
    TvProvider \
    SettingsIntelligence \
    tv_input.default \
    com.android.media.tv.remoteprovider \
    InputDevices
PRODUCT_PROPERTY_OVERRIDES += ro.sf.lcd_density=260
else

# Use Launcher3QuickStep
PRODUCT_PACKAGES += Launcher3QuickStep
endif

#External USB Camera HAL
# PRODUCT_PACKAGES += \
#     android.hardware.camera.provider@2.5-external-service \
# 
# PRODUCT_COPY_FILES += \
#     device/glodroid/common/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml
# 
# #Camera HAL
# PRODUCT_PACKAGES += \
#     camera.libcamera \
#     android.hardware.camera.provider@2.5-service_64 \
# 
# PRODUCT_PROPERTY_OVERRIDES += ro.hardware.camera=libcamera

# PRODUCT_COPY_FILES +=  \
#     frameworks/native/data/etc/android.hardware.camera.concurrent.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.concurrent.xml \
#     frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
#     frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
#     frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
#     frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \

# Copy hardware config file(s)
PRODUCT_COPY_FILES +=  \
        device/linaro/hikey/etc/permissions/android.software.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.xml \
        frameworks/native/data/etc/android.software.cts.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.cts.xml \
        frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \
        frameworks/native/data/etc/android.software.backup.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.backup.xml \
        frameworks/native/data/etc/android.software.voice_recognizers.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.voice_recognizers.xml \
        frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
        frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
        frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
        frameworks/native/data/etc/android.software.device_admin.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_admin.xml

PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
        frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
        device/linaro/hikey/wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf \
        device/linaro/hikey/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
        device/linaro/hikey/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf

# audio policy configuration
USE_XML_AUDIO_POLICY_CONF := 1
PRODUCT_COPY_FILES += \
    device/glodroid/common/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml

# Copy media codecs config file
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml \
    device/glodroid/common/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \

PRODUCT_COPY_FILES += \
    device/glodroid/common/init.common.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.common.rc \


################# ADDITIONAL PACKAGES SECTION #########################

PRODUCT_COPY_FILES += \
    device/glodroid/common/preinstall.sh:$(TARGET_COPY_OUT_VENDOR)/etc/preinstall/preinstall.sh \
    device/glodroid/common/applications/AutoKit.apk:$(TARGET_COPY_OUT_VENDOR)/etc/preinstall/AutoKit.apk_ \

PRODUCT_PACKAGES += \
    AutoKit \

################################################################################

PRODUCT_PACKAGES += fstab

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.zram:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.zram \

# Init RC files
PRODUCT_COPY_FILES += \
    device/glodroid/common/ueventd.common.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \

# Build and run only ART
PRODUCT_RUNTIMES := runtime_libart_default

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/drm.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/drm.rc \
    device/glodroid/common/init.common.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.common.usb.rc \

# Vendor seccomp policy files:
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp_policy/mediaswcodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaswcodec.policy \
    $(LOCAL_PATH)/seccomp_policy/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.glodroid.rc:recovery/root/init.recovery.$(TARGET_PRODUCT).rc \

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := true

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/virtual_touchscreen_websocket_relay:$(TARGET_COPY_OUT_VENDOR)/bin/virtual_touchscreen_websocket_relay \

################################################################################

# Screen orientation lock
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.screen.landscape.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.landscape.xml \

PRODUCT_PROPERTY_OVERRIDES += \
    config.override_forced_orient=false \
    ro.sf.hwrotation=0 \
    persist.demo.hdmirotation=landscape \
    persist.demo.rotationlock=true \
    persist.demo.remoterotation=landscape \

################################################################################

# Aurora Store and microG

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/aurora/permissions_com.aurora.services.xml:system/etc/permissions/permissions_com.aurora.services.xml \

PRODUCT_PACKAGES += \
	AuroraServices \
    AuroraStore \
    
$(call inherit-product, vendor/partner_gms/products/gms.mk)    

################################################################################

# LineageOS browser

PRODUCT_PACKAGES += \
    Jelly \

################################################################################

# usb_modeswitch

PRODUCT_PACKAGES += \
    usb_modeswitch \
    
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/usb_modeswitch.conf:$(TARGET_COPY_OUT_VENDOR)/etc/usb_modeswitch.conf \
    
################################################################################

# v4l2

PRODUCT_PACKAGES += \
    v4l2-dbg \
    v4l2-compliance \
    v4l2-ctl \
    
################################################################################

# Audio Capture
    
PRODUCT_PACKAGES += \
    AudioCapture \
    
PRODUCT_COPY_FILES += \
    device/glodroid/common/audiocapture/startAudioCapture.sh:$(TARGET_COPY_OUT_VENDOR)/etc/startAudioCapture.sh \
        
################################################################################
    
PRODUCT_PACKAGES += \
    glodroid_overlay_frameworks_base_core \
    glodroid_overlay_settings_provider \
    glodroid_overlay_systemui \
    glodroid_overlay_service_wifi_resources \

PRODUCT_SOONG_NAMESPACES += device/glodroid