/*
   Copyright (C) 2017, The XPerience Project (Klozz Jesus AKA TeamMEX)
   Copyright (c) 2014, The Linux Foundation. All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"

#include <sys/sysinfo.h>

#define ISMATCH(a,b)    (!strncmp(a,b,PROP_VALUE_MAX))

#define CMDLINE_SIZE 1024

//Take care about 2gb ram
int is2GB()
{
    struct sysinfo sys;
    sysinfo(&sys);
    return sys.totalram > 1024ull * 1024 * 1024;
}

//Take care about 3gb ram
int is3GB()
{
    struct sysinfo sys;
    sysinfo(&sys);
    return sys.totalram > 2048ull * 1024 * 1024;
}


void gsm_properties(bool msim);

char const *heapstartsize;
char const *heapgrowthlimit;
char const *heapsize;
char const *heapminfree;
char const *heapmaxfree;
char const *large_cache_height;

static void init_alarm_boot_properties()
{
    int boot_reason;
    FILE *fp;

    fp = fopen("/proc/sys/kernel/boot_reason", "r");
    fscanf(fp, "%d", &boot_reason);
    fclose(fp);

    /*
     * Setup ro.alarm_boot value to true when it is RTC triggered boot up
     * For existing PMIC chips, the following mapping applies
     * for the value of boot_reason:
     *
     * 0 -> unknown
     * 1 -> hard reset
     * 2 -> sudden momentary power loss (SMPL)
     * 3 -> real time clock (RTC)
     * 4 -> DC charger inserted
     * 5 -> USB charger inserted
     * 6 -> PON1 pin toggled (for secondary PMICs)
     * 7 -> CBLPWR_N pin toggled (for external power supply)
     * 8 -> KPDPWR_N pin toggled (power key pressed)
     */
     if (boot_reason == 3) {
        property_set("ro.alarm_boot", "true");
     } else {
        property_set("ro.alarm_boot", "false");
     }
}

void check_ram()
{

   if (is2GB()) {
        // from - phone-xxhdpi-2048-dalvik-heap.mk and HWUI
        property_set("dalvik.vm.heapstartsize", "8m");
        property_set("dalvik.vm.heapgrowthlimit", "96m");
        property_set("dalvik.vm.heapsize", "256m");
        property_set("dalvik.vm.heaptargetutilization", "0.75");
        property_set("dalvik.vm.heapminfree", "2m");
        property_set("dalvik.vm.heapmaxfree", "8m");
        property_set("ro.hwui.texture_cache_size", "72");
        property_set("ro.hwui.layer_cache_size", "48");
        property_set("ro.hwui.r_buffer_cache_size", "8");
        property_set("ro.hwui.path_cache_size", "32");
        property_set("ro.hwui.gradient_cache_size", "1");
        property_set("ro.hwui.drop_shadow_cache_size", "6");
        property_set("ro.hwui.texture_cache_flushrate", "0.4");
        property_set("ro.hwui.text_small_cache_width", "1024");
        property_set("ro.hwui.text_small_cache_height", "1024");
        property_set("ro.hwui.text_large_cache_width", "2048");
        property_set("ro.hwui.text_large_cache_height", "1024");
    } else if(is3GB()){
        // from - phone-xxhdpi-3072-dalvik-heap.mk and HWUI
        property_set("dalvik.vm.heapstartsize", "8m");
        property_set("dalvik.vm.heapgrowthlimit", "192m");
        property_set("dalvik.vm.heapsize", "512m");
        property_set("dalvik.vm.heaptargetutilization", "0.75");
        property_set("dalvik.vm.heapminfree", "512k");
        property_set("dalvik.vm.heapmaxfree", "8m");
        property_set("ro.hwui.texture_cache_size", "72");
        property_set("ro.hwui.layer_cache_size", "48");
        property_set("ro.hwui.r_buffer_cache_size", "8");
        property_set("ro.hwui.path_cache_size", "32");
        property_set("ro.hwui.gradient_cache_size", "1");
        property_set("ro.hwui.drop_shadow_cache_size", "6");
        property_set("ro.hwui.texture_cache_flushrate", "0.4");
        property_set("ro.hwui.text_small_cache_width", "1024");
        property_set("ro.hwui.text_small_cache_height", "1024");
        property_set("ro.hwui.text_large_cache_width", "2048");
        property_set("ro.hwui.text_large_cache_height", "1024");
    } else {
        // from - phone-xxhdpi-4096-dalvik-heap.mk and HWUI 
        property_set("dalvik.vm.heapstartsize", "16m");
        property_set("dalvik.vm.heapgrowthlimit", "256m");
        property_set("dalvik.vm.heapsize", "512m");
        property_set("dalvik.vm.heaptargetutilization", "0.75");
        property_set("dalvik.vm.heapminfree", "4m");
        property_set("dalvik.vm.heapmaxfree", "8m");
        property_set("ro.hwui.texture_cache_size", "72");
        property_set("ro.hwui.layer_cache_size", "48");
        property_set("ro.hwui.r_buffer_cache_size", "8");
        property_set("ro.hwui.path_cache_size", "32");
        property_set("ro.hwui.gradient_cache_size", "1");
        property_set("ro.hwui.drop_shadow_cache_size", "6");
        property_set("ro.hwui.texture_cache_flushrate", "0.4");
        property_set("ro.hwui.text_small_cache_width", "1024");
        property_set("ro.hwui.text_small_cache_height", "1024");
        property_set("ro.hwui.text_large_cache_width", "2048");
        property_set("ro.hwui.text_large_cache_height", "2048");
   }
}

void vendor_load_properties()
{
    std::string platform;
    std::string device;
    char cmdlinebuff[CMDLINE_SIZE];
    char board_id[32];
    FILE *fp;
    platform = property_get("ro.board.platform");

    if (platform != ANDROID_TARGET) {
        return;
    }

    if ((fp = fopen("/proc/cmdline", "r")) == NULL) {
        printf("Failed to open /proc/cmdline");
        return;
    }

    if (fgets(cmdlinebuff, CMDLINE_SIZE, fp) == NULL) {
        return;
    }
    char *boardindex = strstr(cmdlinebuff, "board_id=");
    if (boardindex != NULL) {
        strncpy(board_id, strtok(boardindex + 9, ":"), 32);
    }
    fclose(fp);

    /* S82937AA1 */
    if (ISMATCH(board_id, "S82937AA1")){
    property_set("ro.product.device", "K33a48");
    property_set("ro.build.product", "K33a48");
    property_set("ro.product.model", "Lenovo K33a48");
    property_set("persist.radio.multisim.config", "dsds");
    property_set("ro.telephony.default_network", "9,9");
    property_set("ro.build.fingerprint", "Lenovo/karate/K33a48:7.0/NRD90N/K33_S222_170523_ROW:user/release-keys");

    /* S82937CA1 */
    } else if (ISMATCH(board_id, "S82937CA1")){
    property_set("ro.product.device", "K33a48");
    property_set("ro.build.product", "K33a48");
    property_set("ro.product.model", "Lenovo K33a48");
    property_set("ro.telephony.default_network", "9");
    property_set("ro.build.fingerprint", "Lenovo/karate/K33a48:7.0/NRD90N/K33_S222_170523_ROW:user/release-keys");

    /* S82937DA1 */
    } else if (ISMATCH(board_id, "S82937DA1")){
    property_set("ro.product.device", "K33b36");
    property_set("ro.build.product", "K33b36");
    property_set("ro.product.model", "Lenovo K33b36");
    property_set("persist.radio.multisim.config", "dsds");
    property_set("ro.telephony.default_network", "9,9");
    property_set("ro.build.fingerprint", "Lenovo/karate/K33b36:7.0/NRD90N/K33_S222_170523_ROW:user/release-keys");

    /* S82937EA1 */
    } else if (ISMATCH(board_id, "S82937EA1")){
    property_set("ro.product.device", "K33a37");
    property_set("ro.build.product", "K33a37");
    property_set("ro.product.model", "Lenovo K33b37");
    property_set("ro.telephony.default_network", "9");
    property_set("ro.build.fingerprint", "Lenovo/karate/K33b37:7.0/NRD90N/K33_S222_170523_ROW:user/release-keys");

    /* S82938AA1 */
    } else if (ISMATCH(board_id, "S82938AA1")){
    property_set("ro.product.device", "K33a42");
    property_set("ro.build.product", "K33a42");
    property_set("ro.product.model", "Lenovo K33a42");
    property_set("persist.radio.multisim.config", "dsds");
    property_set("ro.telephony.default_network", "9,9");
    property_set("ro.build.fingerprint", "Lenovo/karate/K33a42:7.0/NRD90N/K33_S222_170523_ROW:user/release-keys");

    /* S82938BA1 */
    } else {
    property_set("ro.product.device", "K33a42");
    property_set("ro.build.product", "K33a42");
    property_set("ro.product.model", "Lenovo K33a42");
    property_set("persist.radio.multisim.config", "dsds");
    property_set("ro.telephony.default_network", "9,9");
    property_set("ro.build.fingerprint", "Lenovo/karate/K33a42:7.0/NRD90N/K33_S222_170523_ROW:user/release-keys");
    }

    init_alarm_boot_properties();
    check_ram();
}
