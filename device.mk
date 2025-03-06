#
# Copyright (C) 2020-2022 The CipherOS Project
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

DEVICE_PATH := device/rabbit/r1

# Boot Animation
TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 720

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := hdpi

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script

# Boot Control
PRODUCT_PACKAGES += \
    com.android.hardware.boot \
    android.hardware.boot-service.default_recovery


# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    hardware/mediatek \
    $(DEVICE_PATH)

# HIDL
PRODUCT_PACKAGES += \
    libhardware \
    libhidltransport \
    libhwbinder

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# The first api level, device has been commercially launched on.
PRODUCT_SHIPPING_API_LEVEL := 31

# Extra VNDK Versions
PRODUCT_EXTRA_VNDK_VERSIONS := 31

# Init
PRODUCT_PACKAGES += \
    init.mt6765.rc \
    fstab.mt6765 \
    init.recovery.mt6765.rc \

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

# Ramdisk
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.mt6765:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6765

# System prop
-include $(DEVICE_PATH)/system_prop.mk
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Kernel
TARGET_PREBUILT_KERNEL := device/rabbit/r1/prebuilt/kernel
PRODUCT_COPY_FILES += \
    $(TARGET_PREBUILT_KERNEL):kernel
