/* SPDX-License-Identifier: AGPL-3.0-or-later
 * Компоновка uCode (второй CPU ARC600).
 *
 * Адресное пространство uc (рантайм):
 *   код   0x0 .. 0x20000 (ICCM, 0-базово; в .fw — по 0x920000, 128 КБ)
 *   данные uc 0x940000 ..         (uc_data — отдельная секция .fw)
 *   разделяемые данные fw 0x800000 .. 0x807fff — через абсолютные адреса
 *   (gp=0x800528, sp=0x803a48 — в разделяемой области fw-данных).
 */
MEMORY
{
    /* Код линкуется в 0-базовую проекцию ICCM (как vendor: векторы и указатели
     * 0-базовые, «j L_x-0x920000»); в .fw загружается по 0x920000. Медленность
     * исполнения из 0x92xxxx не подтвердилась (2026-10-16): vendor, у которого
     * rx_flow_handle_frame вызван через 0x931f04, — 3 из 3 nolost под iperf, хотя
     * +12..18 тактов на этом пути его валят. */
    CODE (rx)  : ORIGIN = 0x0, LENGTH = 0x20000
    DATA (rw)  : ORIGIN = 0x940000, LENGTH = 0x8000
}

ENTRY(_uc_reset)

SECTIONS
{
    .vectors : {
        KEEP(*(.vectors))
        . = ALIGN(0x80);
    } > CODE

    .text : {
        *(.text.startup)
        *(.text .text.*)
        *(.rodata .rodata.*)
        KEEP(*(.uc_keep))
    } > CODE

    .data : {
        *(.data .data.*)
    } > DATA

    .bss (NOLOAD) : {
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end = .;
    } > DATA

    __stack_top = 0x803a48;
    /* Кольцо журнала MAC-команд по r25 (uc_mac_cmd, include/arc.h): 0x800000..0x8003ff, 1 КБ,
     * заворот bclr r25 бит 10; начало — хосту в RGF_USER_USAGE_3 (REGS-KNOWN). */
    mac_cmd_log = 0x800000;
    __gp = 0x800528;          /* база gp-адресации, как vendor (uc/start.S) */

    /* VENDOR_CB(): колбэки, которые vendor хранил как 0-базовые адреса (см. include/arc.h).
     * В полном образе — наши функции; гибрид (tools/uc_hybrid.py) задаёт vendor-адреса. */
    PROVIDE(__vcb_924898 = bf_req_report_20_cb);
    PROVIDE(__vcb_92490c = bf_req_report_21_cb);
    PROVIDE(__vcb_92e468 = bf_req_report_26_cb);
    PROVIDE(__vcb_9281f8 = bf_req_claim_and_report_23);
    PROVIDE(__vcb_924e9c = bf_req_claim_and_report_2b);
    PROVIDE(__vcb_935748 = rf_gain_adjust_cb);
    PROVIDE(__vcb_93b39c = abft_send_ssw_feedback);
    PROVIDE(__vcb_93b3fc = direct_tx_short_frame0_cb);
    PROVIDE(__vcb_93b404 = direct_tx_short_frame2_cb);

    /DISCARD/ : {
        *(.comment)
        *(.note*)
    }
}
