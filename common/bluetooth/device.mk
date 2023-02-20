# SPDX-License-Identifier: Apache-2.0

PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service \
    libbt-vendor \

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += \
    android.hardware.bluetooth.audio-impl \
    audio.bluetooth.default

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml

PRODUCT_VENDOR_PROPERTIES += \
	bluetooth.device.class_of_device=90,2,12 \
	bluetooth.profile.asha.central.enabled=true \
	bluetooth.profile.a2dp.source.enabled=true \
	bluetooth.profile.avrcp.target.enabled=true \
	bluetooth.profile.bap.broadcast.assist.enabled=true \
	bluetooth.profile.bap.unicast.client.enabled=true \
	bluetooth.profile.bas.client.enabled=true \
	bluetooth.profile.csip.set_coordinator.enabled=true \
	bluetooth.profile.gatt.enabled=true \
	bluetooth.profile.hap.client.enabled=true \
	bluetooth.profile.hfp.ag.enabled=true \
	bluetooth.profile.hid.device.enabled=true \
	bluetooth.profile.hid.host.enabled=true \
	bluetooth.profile.map.server.enabled=true \
	bluetooth.profile.mcp.server.enabled=true \
	bluetooth.profile.opp.enabled=true \
	bluetooth.profile.pan.nap.enabled=true \
	bluetooth.profile.pan.panu.enabled=true \
	bluetooth.profile.pbap.server.enabled=true \
	bluetooth.profile.sap.server.enabled=true \
	bluetooth.profile.ccp.server.enabled=true \
	bluetooth.profile.vcp.controller.enabled=true \
	persist.bluetooth.a2dp_aac.vbr_supported=true \
	ro.rfkilldisabled=1