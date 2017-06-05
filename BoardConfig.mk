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

-include vendor/lenovo/karate/BoardConfigVendor.mk

LOCAL_PATH := device/lenovo/karate

BOARD_VENDOR := lenovo-qcom

TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

# Platform
TARGET_BOARD_PLATFORM := msm8937
TARGET_BOARD_PLATFORM_GPU := qcom-adreno505

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8937
TARGET_NO_BOOTLOADER := true

# Architecture
TARGET_GLOBAL_CFLAGS     += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS   += -mfpu=neon -mfloat-abi=softfp
TARGET_ARCH              := arm
TARGET_ARCH_VARIANT      := armv7-a-neon
TARGET_CPU_ABI           := armeabi-v7a
TARGET_CPU_ABI2          := armeabi
TARGET_CPU_VARIANT       := cortex-a53

# Asserts
TARGET_OTA_ASSERT_DEVICE := karate, karate_row, K33, LenovoK33a48_ROW

# Kernel
BOARD_KERNEL_CMDLINE := console=tty60,115200,n8 androidboot.console=tty60 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 vmalloc=350M
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
#BOARD_KERNEL_SEPARATED_DT := true
#BOARD_KERNEL_LZ4C_DT := true
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100
TARGET_KERNEL_ARCH := arm
#LOCAL_KERNEL := device/lenovo/karate/kernel #use prebuiltkernel
TARGET_KERNEL_CONFIG := karate_defconfig
TARGET_KERNEL_SOURCE := kernel/lenovo/msm8937
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
TARGET_KERNEL_APPEND_DTB := true

# Audio
AUDIO_FEATURE_ENABLED_COMPRESS_VOIP := true
AUDIO_FEATURE_ENABLED_EXTN_FORMATS := true
AUDIO_FEATURE_ENABLED_FLAC_OFFLOAD := true
AUDIO_FEATURE_ENABLED_FLUENCE      := true
AUDIO_FEATURE_ENABLED_HFP          := true
AUDIO_FEATURE_ENABLED_KPI_OPTIMIZE := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_ENABLED_PCM_OFFLOAD := true
AUDIO_FEATURE_ENABLED_PCM_OFFLOAD_24 := true
BOARD_USES_ALSA_AUDIO := true
USE_CUSTOM_AUDIO_POLICY := 1
#USE_XML_AUDIO_POLICY_CONF := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true
QCOM_BT_USE_BTNV := true
QCOM_BT_USE_SMD_TTY := true

# Camera
TARGET_CAMERASERVICE_CLOSES_NATIVE_HANDLES := true
USE_DEVICE_SPECIFIC_CAMERA := true

# Charger
BACKLIGHT_PATH := /sys/class/leds/lcd-backlight/brightness
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true
#BOARD_NO_CHARGER_LED := true

# CMHW
BOARD_USES_CYANOGEN_HARDWARE := true
BOARD_HARDWARE_CLASS += hardware/cyanogen/cmhw

# Crypto
#TARGET_HW_DISK_ENCRYPTION := true

# Display
HAVE_ADRENO_SOURCE              := false
BOARD_USES_ADRENO               := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
OVERRIDE_RS_DRIVER              := libRSDriver_adreno.so
TARGET_USES_C2D_COMPOSITION     := true
TARGET_USES_ION                 := true
TARGET_USES_NEW_ION_API         := true
USE_OPENGL_RENDERER             := true
MAX_EGL_CACHE_KEY_SIZE          := 12*1024
MAX_EGL_CACHE_SIZE              := 2048*1024

# FM
AUDIO_FEATURE_ENABLED_FM_POWER_OPT := true
TARGET_QCOM_NO_FM_FIRMWARE         := true

# Init
#TARGET_INIT_VENDOR_LIB := libinit_karate
#TARGET_RECOVERY_DEVICE_MODULES := libinit_karate

# Keymaster
TARGET_PROVIDES_KEYMASTER := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Media
TARGET_USES_MEDIA_EXTENSIONS := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216        #    16384 * 1024 mmcblk0p37
BOARD_CACHEIMAGE_PARTITION_SIZE := 260014080      #   253920 * 1024 mmcblk0p52
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16879616    #    16484 * 1024 mmcblk0p38
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 455451136    #  3428080 * 1024 mmcblk0p53
BOARD_USERDATAIMAGE_PARTITION_SIZE := 26401026048 # 25782252 * 1024 mmcblk0p54

# Peripheral manager
TARGET_PER_MGR_ENABLED := true

# Power
TARGET_POWERHAL_VARIANT := qcom

# Qualcomm support
BOARD_USES_QCOM_HARDWARE := true
BOARD_USES_QC_TIME_SERVICES := true
TARGET_USE_SDCLANG := true

# Radio
#BOARD_PROVIDES_LIBRIL := true
#BOARD_PROVIDES_RILD := true
TARGET_RIL_VARIANT := caf

#Dex pre-opt 
ifeq ($(HOST_OS),linux)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_PIC := true
      ifneq ($(TARGET_BUILD_VARIANT),user)
        # Retain classes.dex in APK's for non-user builds
        DEX_PREOPT_DEFAULT := nostripping
      endif
    endif
endif

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_FSTAB      := $(LOCAL_PATH)/rootdir/etc/fstab.qcom
TARGET_USERIMAGES_USE_EXT4 := true
#TARGET_USERIMAGES_USE_F2FS := true

# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

# SELinux
include device/qcom/sepolicy/sepolicy.mk
BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/sepolicy

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_WLAN_DEVICE                := qcwcn
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_NAME          := "wlan"
WPA_SUPPLICANT_VERSION           := VER_0_8_X
