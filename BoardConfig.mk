#
# Copyright (C) 2021-2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm8150-common
include device/xiaomi/sm8150-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/nabu

NABU_KERNEL_PREBUILT := true
NABU_KERNEL := false
COMMON_KERNEL := false

BUILD_BROKEN_DUP_RULES := true

# Board
TARGET_BOOTLOADER_BOARD_NAME := nabu

# Assert
TARGET_OTA_ASSERT_DEVICE := nabu

# Display
TARGET_SCREEN_DENSITY := 440

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop

ifeq ($(NABU_KERNEL_PREBUILT),true)
#vendor_cmdline
VENDOR_CMDLINE := "console=ttyMSM0,115200n8 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=2048 loop.max_part=7 cgroup.memory=nokmem,nosocket reboot=panic_warm androidboot.init_fatal_reboot_target=recovery androidboot.selinux=permissive androidboot.vbmeta.avb_version=1.0 androidboot.boot_devices=soc/1d84000.ufshc"
#Kernel Variables
BOARD_BOOT_HEADER_VERSION := 3
BOARD_KERNEL_PAGESIZE := 4096
TARGET_FORCE_PREBUILT_KERNEL := true #Needed to compile with the Kernel Prebuilt.
#Targets
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/$(PRODUCT_RELEASE_NAME)/kernel
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(VENDOR_CMDLINE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE) --board ""
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/$(PRODUCT_RELEASE_NAME)/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/$(PRODUCT_RELEASE_NAME)/dtbo.img
endif

ifeq ($(NABU_KERNEL),true)
BOARD_BOOT_HEADER_VERSION := 3
#KERNEL_LD := LD=ld.lld
TARGET_KERNEL_ADDITIONAL_FLAGS := DTC_EXT=$(shell pwd)/prebuilts/misc/linux-x86/dtc/dtc
TARGET_KERNEL_SOURCE := kernel/xiaomi/nabu-kernel
TARGET_KERNEL_CONFIG := nabu_user_defconfig
endif

ifeq ($(COMMON_KERNEL),true)
TARGET_KERNEL_SOURCE := kernel/xiaomi/sm8150-legacy
TARGET_KERNEL_CONFIG += vendor/xiaomi/nabu.config
endif

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_xiaomi_nabu
TARGET_RECOVERY_DEVICE_MODULES := init_xiaomi_nabu

# Inherit from the proprietary version
include vendor/xiaomi/nabu/BoardConfigVendor.mk