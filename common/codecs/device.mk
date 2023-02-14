# SPDX-License-Identifier: Apache-2.0
#
# GloDroid project (https://github.com/GloDroid)
#
# Copyright (C) 2022 Roman Stratiienko (r.stratiienko@gmail.com)

PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.0-service \

# Create input surface on the framework side
PRODUCT_VENDOR_PROPERTIES += \
    debug.stagefright.c2inputsurface=-1 \

# Copy media codecs config file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/media_codecs_v4l2_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_v4l2_c2_video.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml \
    $(LOCAL_PATH)/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \

# Vendor seccomp policy files:
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/codec2.vendor.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.vendor.ext.policy \
    $(LOCAL_PATH)/mediaswcodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaswcodec.policy \
    $(LOCAL_PATH)/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \

# FFmpeg
PRODUCT_PACKAGES += \
     android.hardware.media.c2@1.2-service-ffmpeg

PRODUCT_VENDOR_PROPERTIES += \
     persist.ffmpeg_codec2.v4l2.h264=true \
     persist.ffmpeg_codec2.v4l2.h265=true \
     persist.ffmpeg_codec2.rank.audio=16 \
     persist.ffmpeg_codec2.rank.video=256 \

# V4L2 codec2
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.0-service-v4l2 \
    libc2plugin_store                          \

PRODUCT_SOONG_NAMESPACES += external/v4l2_codec2

# Set the customized property of v4l2_codec2, including:
# - The maximum concurrent instances for decoder/encoder.
#   It should be the same as "concurrent-instances" at media_codec_c2.xml.
PRODUCT_PROPERTY_OVERRIDES += \
    persist.v4l2_codec2.rank.decoder=128 \
    persist.v4l2_codec2.rank.encoder=128 \
    ro.vendor.v4l2_codec2.decode_concurrent_instances=8 \
    ro.vendor.v4l2_codec2.encode_concurrent_instances=8 \

# Codec2.0 poolMask:
#   ION(16)
#   GRALLOC(17)
#   BUFFERQUEUE(18)
#   BLOB(19)
#   V4L2_BUFFERQUEUE(20)
#   V4L2_BUFFERPOOL(21)
#   SECURE_LINEAR(22)
#   SECURE_GRAPHIC(23)
#
# For linear buffer allocation:
#   If ION is chosen, then the mask should be 0xf50000
#   If GRALLOC is chosen, then the mask should be 0xf60000
#   If BLOB is chosen, then the mask should be 0xfc0000
PRODUCT_PROPERTY_OVERRIDES += \
    debug.stagefright.c2-poolmask=0x0c0000 \
