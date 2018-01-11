#
# Copyright (C) 2011 The CyanogenMod Project
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Get non-open-source specific aspects
$(call inherit-product-if-exists, vendor/samsung/mondrianwifi/mondrianwifi-vendor.mk)

## We are a tablet, not a phone
PRODUCT_CHARACTERISTICS := tablet

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := xlarge
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1600

$(call inherit-product, frameworks/native/build/tablet-7in-xhdpi-2048-dalvik-heap.mk)

$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/mixer_paths.xml:system/etc/mixer_paths.xml

ifeq ($(SLIM_FULL),true)
# Use standard audio_effects.conf for full build
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects_default.conf:system/vendor/etc/audio_effects.conf
else
# Use custom audio_effects.conf for essential build (required for Viper4Android)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.conf:system/vendor/etc/audio_effects.conf
endif

# BoringSSL Hack
PRODUCT_PACKAGES += \
    libboringssl-compat

# Apache Hack
PRODUCT_COPY_FILES += \
    prebuilts/sdk/org.apache.http.legacy/org.apache.http.legacy.jar:/system/framework/org.apache.http.legacy.jar

# Camera
PRODUCT_PACKAGES += \
    camera.msm8974 \
    libshim_qcopt \
    libxml2

#    Snap \

# GPS
PRODUCT_PACKAGES += \
    gps.msm8974

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/etc/gps.conf:/system/etc/gps.conf \
    $(LOCAL_PATH)/gps/etc/sap.conf:/system/etc/sap.conf

# Input device
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/sec_e-pen.idc:system/usr/idc/sec_e-pen.idc

# IR
PRODUCT_PACKAGES += \
    consumerir.msm8974

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl \
    $(LOCAL_PATH)/keylayout/Button_Jack.kl:system/usr/keylayout/Button_Jack.kl \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/keylayout/philips_remote_ir.kl:system/usr/keylayout/philips_remote_ir.kl \
    $(LOCAL_PATH)/keylayout/samsung_remote_ir.kl:system/usr/keylayout/samsung_remote_ir.kl \
    $(LOCAL_PATH)/keylayout/sec_touchscreen.kl:system/usr/keylayout/sec_touchscreen.kl \
    $(LOCAL_PATH)/keylayout/ue_rf4ce_remote.kl:system/usr/keylayout/ue_rf4ce_remote.kl

# Keystore
PRODUCT_PACKAGES += \
    keystore.msm8974

# Lights
PRODUCT_PACKAGES += \
    lights.msm8974

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml

PRODUCT_PROPERTY_OVERRIDES += \
    av.streaming.offload.enable=false

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.carrier.rc \
    init.crda.sh \
    init.input.sh \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.target.rc \
    ueventd.qcom.rc

# Stlport
PRODUCT_PACKAGES += \
    libstlport

# rmt_storage
PRODUCT_PACKAGES += \
    libshim_rmt_storage

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine-8974.conf:system/etc/thermal-engine-8974.conf \
    $(LOCAL_PATH)/configs/thermald-8974.conf:system/etc/thermald-8974.conf

# Wifi
PRODUCT_PACKAGES += \
    dhcpcd.conf \
    hostapd \
    libwcnss_qmi \
    libwpa_client \
    wcnss_service \
    wpa_supplicant

PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/configs/hostapd.accept:system/etc/hostapd/hostapd.accept \
   $(LOCAL_PATH)/configs/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
   $(LOCAL_PATH)/configs/hostapd.deny:system/etc/hostapd/hostapd.deny \
   $(LOCAL_PATH)/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
   $(LOCAL_PATH)/configs/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
   $(LOCAL_PATH)/configs/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# SuperSU, BusyBox, screen binary, custom bootanimation and Viper4Android are present only in essential build (default)
ifneq ($(SLIM_FULL),true)
# SuperSU
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/SuperSU/supersu:system/addon.d/supersu \
    $(LOCAL_PATH)/SuperSU/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
    $(LOCAL_PATH)/SuperSU/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# BusyBox
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/BusyBox/UPDATE-BusyBox.zip:system/addon.d/UPDATE-BusyBox.zip

# Screen binary
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/screen/screen:system/bin/screen

# Custom bootanimation
PRODUCT_BOOTANIMATION := device/samsung/mondrianwifi/bootanimation/bootanimation.zip

ifneq ($(TARGET_ARCH),arm64)
# Viper4Android
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/Viper4Android/addon.d/23-v4a.sh:system/addon.d/23-v4a.sh \
    $(LOCAL_PATH)/Viper4Android/etc/init.d/50viper:system/etc/init.d/55viper \
    $(LOCAL_PATH)/Viper4Android/lib/soundfx/libv4a_fx_ics.so:system/lib/soundfx/libv4a_fx_ics.so \
    $(LOCAL_PATH)/Viper4Android/xbin/seinfo:system/xbin/seinfo \
    $(LOCAL_PATH)/Viper4Android/xbin/sepolicy-inject:system/xbin/sepolicy-inject \
    $(LOCAL_PATH)/Viper4Android/xbin/sesearch:system/xbin/sesearch \
    $(LOCAL_PATH)/Viper4Android/priv-app/Viper/ViperFX.apk:system/priv-app/Viper/ViperFX.apk
endif
endif

# Common msm8974
$(call inherit-product, device/samsung/msm8974-common/msm8974.mk)
