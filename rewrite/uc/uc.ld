/* SPDX-License-Identifier: AGPL-3.0-or-later
 * Компоновка uCode (второй CPU ARC600).
 *
 * Адресное пространство uc (рантайм):
 *   код   0x0 .. 0x20000 (ICCM, 0-базово; в .fw — по 0x920000, 128 КБ)
 *   данные uc 0x940000 ..         (uc_data — отдельная секция .fw)
 *   разделяемые данные fw 0x800000 .. 0x807fff — через абсолютные адреса
 *   (gp=0x800528, sp=0x804000 — в разделяемой области fw-данных).
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
        . = 0xf8;
        LONG(__clkpatch_hdr)            /* CLKK_TABLE_PTR_UC (uc/clkk.h) */
        . = ALIGN(0x80);
    } > CODE
    ASSERT(SIZEOF(.vectors) == 0x100, "uc: .vectors — 0x100 Б (слово CLKK по 0xf8)")

    .text : {
        *(.text.startup)
        *(.text .text.*)
        *(.rodata .rodata.*)
        KEEP(*(.uc_keep))
    } > CODE

    /* Таблица CLKK (uc/clkk.h) — сразу за кодом: метка 'CLKK', число записей, записи (адрес поля limm | номер << 24).
     * Её адрес — слово CLKK_TABLE_PTR_UC в хвосте .vectors (векторы кончаются на 0xa0, .vectors дополнен до 0x100 — код не
     * сдвигается). fw вписывает значения при текущем такте ядра перед пуском uc (fw/lmac.c clkk_patch_uc). */
    .clkpatch : {
        __clkpatch_hdr = .;
        LONG(0x4b4b4c43)
        LONG((__clkpatch_end - __clkpatch_start) / 4)
        __clkpatch_start = .;
        KEEP(*(.clkpatch))
        __clkpatch_end = .;
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
    /* Регион DATA (0x940000) — адрес загрузки uc_data в .fw (вид хоста/fw), а не рантайм-адрес данных uc (DCCM 0x800000):
     * static-переменная uc попала бы в чужую память (опыт fc2: static в abft_responder_fast ронял станцию). */
    ASSERT(SIZEOF(.data) == 0 && SIZEOF(.bss) == 0,
           "uc: .data/.bss запрещены - переменные uc только по фиксированным адресам DCCM (dccm.h)")

    /* Вершина стека — конец стековой области DCCM 0x804000 (выше — буфер приёма MAC, rx_buf 0x804010…). Было
     * 0x803a48 (как vendor): стек 1 КБ. Область 0x803a48..0x803fff не пишут ни загрузчик, ни uc, ни fw (стенд
     * 2026-10-28: внутри загрузки неизменна, между загрузками — разный мусор SRAM; fw её не адресует), а дампы стека
     * считают её стеком — fw sysassert_dump_ucode_stack и uc uc_sysassert_scan_stack идут от sp до 0x944000 (окно fw)
     * = 0x804000. Стек 2488 Б: запас для вылазок L1 из фоновых задач (tools/arcemu/stack_budget.py). */
    __stack_top = 0x804000;
    __stack_bottom = 0x803648;    /* конец журнала uc_log (0x803234 + 0x414, uc/dccm.h) — дно стека и закраски */
    /* Кольцо журнала MAC-команд по r25 (uc_mac_cmd, include/arc.h): 0x800000..0x8003ff, 1 КБ,
     * заворот bclr r25 бит 10; начало — хосту в RGF_USER_USAGE_3 (REGS-KNOWN). */
    mac_cmd_log = 0x800000;
    __gp = 0x800528;          /* база gp-адресации, как vendor (uc/start.S) */

    /* VENDOR_CB(): колбэки, которые vendor хранил как 0-базовые адреса (см. include/arc.h).
     * В полном образе — наши функции; гибрид (tools/uc_hybrid.py) задаёт vendor-адреса. */
    PROVIDE(__vcb_924898 = bf_req_report_energy_cb);
    PROVIDE(__vcb_92490c = bf_req_report_plcp_cb);
    PROVIDE(__vcb_92e468 = bf_req_report_phystat_cb);
    PROVIDE(__vcb_9281f8 = bf_req_report_pkt_cb);
    PROVIDE(__vcb_924e9c = bf_req_report_chest_cb);
    PROVIDE(__vcb_935748 = rf_gain_adjust_cb);
    PROVIDE(__vcb_93b39c = abft_send_ssw_feedback);
    PROVIDE(__vcb_93b3fc = direct_tx_short_frame0_cb);
    PROVIDE(__vcb_93b404 = direct_tx_short_frame2_cb);

    /DISCARD/ : {
        *(.comment)
        *(.note*)
    }
}
