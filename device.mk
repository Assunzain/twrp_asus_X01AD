# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

PRODUCT_PRODUCT_PROPERTIES += \
    ro.fastbootd.available=true

# Shipping API Level
PRODUCT_SHIPPING_API_LEVEL := 27

PRODUCT_PROPERTY_OVERRIDES += \
    keymaster_ver=3.0

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
