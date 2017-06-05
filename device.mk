#
# Copyright (C) 2017 The XPerience Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)
$(call inherit-product, frameworks/native/build/phone-xxhdpi-2048-dalvik-heap.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Feature definition files for msm8937
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:system/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:system/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.print.xml:system/etc/permissions/android.software.print.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

#sensor hal conf
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors/hals.conf:system/etc/sensors/hals.conf

#for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files

# Screen density
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
PRODUCT_AAPT_CONFIG      := normal

# Audio
PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio.primary.msm8937 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqcompostprocbundle \
    tinymix \
    cplay \
    tinycap \
    tinypcminfo \
    tinyplay

#Audio files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/mixer_paths_karate.xml:system/etc/mixer_paths_karate \
    $(LOCAL_PATH)/configs/mixer_paths_karate_a42.xml:system/etc/mixer_paths_karate_a42.xml \
    $(LOCAL_PATH)/configs/mixer_paths_karate_a48.xml:system/etc/mixer_paths_karate_a48.xml \
    $(LOCAL_PATH)/configs/mixer_paths_karate_b36.xml:system/etc/mixer_paths_karate_b36.xml \
    $(LOCAL_PATH)/configs/media_profiles_8956.xml:system/etc/media_profiles_8956.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_codecs_8956.xml:system/etc/media_codecs_8956.xml \
    $(LOCAL_PATH)/configs/ftm_test_config:system/etc/ftm_test_config \
    $(LOCAL_PATH)/configs/ftm_test_config_wcd9335:system/etc/ftm_test_config_wcd9335 \
    $(LOCAL_PATH)/configs/fts_test_karate_ofilm.ini:system/etc/fts_test_karate_ofilm \
    $(LOCAL_PATH)/configs/fts_test_karate_plus_ofilm.ini:system/etc/fts_test_karate_plus_ofilm.ini \
    $(LOCAL_PATH)/configs/audio_effects.conf:system/etc/audio_effects.conf \
    $(LOCAL_PATH)/configs/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/configs/audio_policy.conf:system/etc/audio_policy.conf

#GPS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/etc/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/gps/etc/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/gps/etc/izat.conf:system/etc/izat.conf \
    $(LOCAL_PATH)/gps/etc/lowi.conf:system/etc/lowi.conf \
    $(LOCAL_PATH)/gps/etc/sap.conf:system/etc/sap.conf \
    $(LOCAL_PATH)/gps/etc/xtwifi.conf:system/etc/xtwifi.conf

# Display
PRODUCT_PACKAGES += \
    gralloc.msm8937 \
    copybit.msm8937 \
    liboverlay \
    hwcomposer.msm8937 \
    memtrack.msm8937 \
    libtinyxml

#Display calibration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/qdcm_calib_data_ili7807d_1080p_video_YAS.xml:system/etc/qdcm_calib_data_ili7807d_1080p_video_YAS.xml \
    $(LOCAL_PATH)/configs/qdcm_calib_data_otm1901a_1080p_video_TianMa.xml:system/etc/qdcm_calib_data_otm1901a_1080p_video_TianMa.xml

# DRM
PRODUCT_PACKAGES += \
    libprotobuf-cpp-lite

# Ebtables
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes \
    libebtc

 Fingerprint
PRODUCT_PACKAGES += \
    fingerprintd

# IPA Manager
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml

# IRSC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:system/etc/sec_config

# Lights
PRODUCT_PACKAGES += \
    lights.msm8937

# Media
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libmm-omxcore

# OMX
PRODUCT_PACKAGES += \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxVdec \
    libOmxVenc \
    libOmxVidcCommon \
    libstagefrighthw

# Power
PRODUCT_PACKAGES += \
    power.msm8937

# RIL
PRODUCT_PACKAGES += \
    librmnetctl \
    libxml2 \
    rmnetcli

# Wifi
PRODUCT_PACKAGES += \
    hostapd_default.conf \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_PACKAGES += \
    p2p_supplicant_overlay.conf \
    wpa_supplicant_overlay.conf

PRODUCT_PACKAGES += \
    libcurl \
    libqsap_sdk \
    libQWiFiSoftApCfg \
    tcpdump \
    wcnss_service \
    libwifi-hal-qcom

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
