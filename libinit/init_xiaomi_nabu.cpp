/*
 * Copyright (C) 2021-2022 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_dalvik_heap.h>
#include <libinit_variant.h>

#include "vendor_init.h"

#define FINGERPRINT "Xiaomi/nabu_global/nabu:11/RKQ1.200826.002/V13.0.4.0.RKXMIXM:user/release-keys"

static const variant_info_t nabu_global_info = {
    .hwc_value = "GLOBAL",
    .sku_value = "",

    .brand = "Xiaomi",
    .device = "nabu",
    .marketname = "",
    .model = "Xiaomi Pad 5",
    .build_fingerprint = FINGERPRINT,

    .nfc = NFC_TYPE_NONE,
};

static const variant_info_t nabu_cn_info = {
    .hwc_value = "CHINA",
    .sku_value = "",

    .brand = "Xiaomi",
    .device = "nabu",
    .marketname = "",
    .model = "Xiaomi Pad 5 China",
    .build_fingerprint = FINGERPRINT,

    .nfc = NFC_TYPE_NONE,
};


static const std::vector<variant_info_t> variants = {
    nabu_global_info,
    nabu_cn_info,
};

void vendor_load_properties() {
    set_dalvik_heap();
    search_variant(variants);
}