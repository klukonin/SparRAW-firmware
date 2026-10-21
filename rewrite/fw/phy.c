// SPDX-License-Identifier: AGPL-3.0-or-later
/* PHY-инициализация и статус. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/fwdata.h"


/* hwd_PHY_STORE_TXRX_SWAP_IQ (0x8d2d10): флаги SWAP_IQ (TX — [0x884028] == 3, RX —
 * [0x883038] == 3) в g_default_tx/rx_swap_iq (st.as [gp,56]/[gp,55]) + журнал (прежде
 * журнала не было). */
void hwd_phy_store_txrx_swap_iq(void)
{
    u32 a = (MMIO32(PHY_TX_SWAP_IQ) == 3);
    phy_default_tx_swap_iq = a;   /* [gp,56] */
    u32 b = (MMIO32(PHY_RX_SWAP_IQ) == 3);
    phy_default_rx_swap_iq = b;   /* [gp,55] */
    fw_log_emit2(0x21, 0x101d900, a, b);
}

/* baseband__identify (0x8f4c9c, 160 Б): тип baseband по ID 0x880b34 → u16 [0x880a8c]
 * (сначала 0). M_A0 = 3, M_A1 = 4; 0x2632072f — по маске 0x88afe4: бит 1 → D0 (7),
 * бит 0 → C0 (6), иначе B0 (5); неизвестный ID — лог и поле остаётся 0. Логи — как vendor
 * (прежде отсутствовали все, кроме UNKNOWN). */
void baseband_identify(void)
{
    *(volatile u16 *)HW_RGF_USER_FW_REV_ID = 0;
    u32 v = MMIO32(RGF_USER_JTAG_DEV_ID);
    u32 t;
    if (v == 0x632072f) {
        fw_log_emit0(0x20, 0x1000b70);          /* BASEBAND_SPARROW_M_A0 */
        t = 3;
    } else if (v == 0x1632072f) {
        fw_log_emit0(0x20, 0x1000b98);          /* BASEBAND_SPARROW_M_A1 */
        t = 4;
    } else if (v == 0x2632072f) {
        u32 m = MMIO32(RGF_USER_REVISION_ID);
        if (m & 2) {
            fw_log_emit1(0x20, 0x1000bc0, m);   /* BASEBAND_SPARROW_M_D0, baseband_mask */
            t = 7;
        } else if (m & 1) {
            fw_log_emit1(0x20, 0x1000c00, m);   /* BASEBAND_SPARROW_M_C0 (Talyn TestChip) */
            t = 6;
        } else {
            fw_log_emit1(0x20, 0x1000c50, m);   /* BASEBAND_SPARROW_M_B0 */
            t = 5;
        }
    } else {
        fw_log_emit1(0x20, 0x1000b3c, v);       /* BASEBAND_UNKNOWN, dev_id */
        return;
    }
    *(volatile u16 *)HW_RGF_USER_FW_REV_ID = (u16)t;
}

/* 0x8067dc: начальная запись регистров PHY {адрес, значение} до маркера 0xe0d0e0d (hwd_phy_init;
 * 39 пар + маркер). Адреса оставлены числами: это данные vendor-образа (FWDATA, сверка
 * --compare-fw-data), а не обращения кода; имена тех, что названы в hw_regs.h: 0x884028
 * PHY_TX_SWAP_IQ, 0x883038 PHY_RX_SWAP_IQ (остальные — без источника имени). */
struct phy_init_reg {
    u32 addr;                                  /* адрес регистра MMIO; PHY_INIT_END — конец */
    u32 val;
};
#define PHY_INIT_END 0xe0d0e0du
FWDATA(8067dc) const struct phy_init_reg phy_init_regs[40] = {
    { 0x884028, 0x3 }, { 0x883038, 0x3 }, { 0x883d64, 0xd8d8ecfc },
    { 0x883d68, 0x3b573b00 }, { 0x883d6c, 0xecd8d800 }, { 0x883d70, 0x1fc },
    { 0x8831c0, 0xfff6db }, { 0x8831c4, 0xfff75d }, { 0x883130, 0x10 },
    { 0x8851b4, 0x1010 }, { 0x883144, 0x5a }, { 0x883148, 0x20 },
    { 0x883180, 0x4 }, { 0x883188, 0x17 }, { 0x8831bc, 0x73 },
    { 0x88315c, 0xb }, { 0x883160, 0xb }, { 0x883b80, 0x3fdc518 },
    { 0x8831a0, 0x19 }, { 0x883e40, 0x2828c828 }, { 0x883e44, 0x28282828 },
    { 0x883e48, 0xc8c8c828 }, { 0x883e04, 0x8d8d8d8d }, { 0x883e08, 0x8d8d8d8d },
    { 0x883e0c, 0x8d8d8d8d }, { 0x883e10, 0x8d8d8d8d }, { 0x883390, 0x2 },
    { 0x883a60, 0xffff }, { 0x883b98, 0xffff }, { 0x883b40, 0x3 },
    { 0x883b70, 0x300 }, { 0x883b74, 0x80100 }, { 0x883b30, 0x180 },
    { 0x883b2c, 0x3003 }, { 0x88954c, 0x154d }, { 0x889554, 0x5b9a2 },
    { 0x88952c, 0xff0707 }, { 0x889540, 0xffffffff }, { 0x889544, 0xffffffff },
    { PHY_INIT_END, PHY_INIT_END },
};

/* Инициализация PHY — hwd_phy_init (0x8d1ccc): патчит таблицу
 * (адрес, значение) в 0x8067dc до маркера 0xe0d0e0d.
 * 39 пар по 2 слова, максимум 0x28 итераций. vendor перед записью читает целевой
 * регистр (ld_s r2,[r1,0] — результат не используется; чтение сохраняем), после
 * вернувшегося сисассерта 0x133f цикл продолжается. */
void hwd_phy_init(void)
{
    u32 i = 0;
    for (;;) {
        const struct phy_init_reg *e = &phy_init_regs[i];
        u32 a = e->addr;
        if (a == PHY_INIT_END)
            return;
        (void)MMIO32(a);
        u32 v = e->val;
        i++;
        MMIO32(a) = v;
        if (i >= 0x28)
            fw_sysassert_fatal((void *)0, 0x133f);
    }
}

/* 0x803838: коэффициенты TX-фильтра PHY (10 бит) для 0x88416c..0x8842b8 — 4 симметричных набора
 * по 21 отсчёту (phy_load_88416c_table). */
FWDATA(803838) const u16 phy_tx_filter_coef[4 * 21] = {
    0x3f3, 0x3f3, 0x009, 0x01f, 0x012, 0x3de, 0x3b9, 0x3ea, 0x07e, 0x127, 0x172,
    0x127, 0x07e, 0x3ea, 0x3b9, 0x3de, 0x012, 0x01f, 0x009, 0x3f3, 0x3f3,
    0x3f2, 0x3f2, 0x00a, 0x023, 0x014, 0x3db, 0x3b1, 0x3e7, 0x08c, 0x148, 0x19b,
    0x148, 0x08c, 0x3e7, 0x3b1, 0x3db, 0x014, 0x023, 0x00a, 0x3f2, 0x3f2,
    0x3fc, 0x3fb, 0x003, 0x00b, 0x006, 0x3f4, 0x3e7, 0x3f8, 0x02c, 0x068, 0x082,
    0x068, 0x02c, 0x3f8, 0x3e7, 0x3f4, 0x006, 0x00b, 0x003, 0x3fb, 0x3fc,
    0x3f3, 0x3f2, 0x00a, 0x021, 0x013, 0x3dd, 0x3b5, 0x3e9, 0x085, 0x137, 0x186,
    0x137, 0x085, 0x3e9, 0x3b5, 0x3dd, 0x013, 0x021, 0x00a, 0x3f2, 0x3f3,
};

/* phy_load_88416c_table (0x8d46e4): коэффициенты TX-фильтра PHY 0x88416c..0x8842b8 из
 * таблицы u16 0x803838 (4 симметричных набора по 21 10-битному отсчёту; зовётся из
 * power_mngr_check_mode 0x8e24e0 на каждой смене канала). vendor: lp 84 раза
 * `ldh.as r2,[0x803838,r1]` (u16, индекс ×2) → `st_s r2,[0x88416c + r1*4]`. Прежний порт
 * читал u32 (по два коэффициента в регистр, 0x03f303f3 вместо 0x3f3) и выходил на 0xa8 Б за
 * конец таблицы — TX-фильтр, в т. ч. для петлевых калибровок, получал мусор. */
void phy_load_88416c_table(u32 a)
{
    (void)a;
    u32 i;
    for (i = 0; i < 0x54; i++)
        MMIO32(PHY_TX_FIR_COEF + i * 4) = phy_tx_filter_coef[i];
}

/* 0x8038e0: таблица переходов vendor phy__program_channel_regs (0x8d24fc): ldb.x, 4 записей, цель = 0x8d251c + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8038e0) __attribute__((aligned(1))) const u8 phy_program_channel_regs_jt[4] = {
    0x00, 0x09, 0x12, 0x1b,
};

/* Программировать регистры канала (0x8d24fe). */
void phy_program_channel_regs(u32 ch)
{
    switch (ch) {
    case 0:
        MMIO32(PHY_RX_CHANNEL_FREQ_RATIO) = 0x064fcaceu;
        MMIO32(PHY_RX_CHANNEL_CFG) = 0x6b000101u;
        break;
    case 1:
        MMIO32(PHY_RX_CHANNEL_FREQ_RATIO) = 0x068ba2e9u;
        MMIO32(PHY_RX_CHANNEL_CFG) = 0x68000101u;
        break;
    case 2:
        MMIO32(PHY_RX_CHANNEL_FREQ_RATIO) = 0x06c77b03u;
        MMIO32(PHY_RX_CHANNEL_CFG) = 0x65000101u;
        break;
    case 3:
        MMIO32(PHY_RX_CHANNEL_FREQ_RATIO) = 0x0703531eu;
        MMIO32(PHY_RX_CHANNEL_CFG) = 0x62000101u;
        break;
    }
}

/* bits__sign_extend_n (0x8ea8c0, 24 Б): знаковое расширение n-битного значения.
 * Если value > (1<<(n-1))-1, вернуть value - (1<<n). Листовая. */
__attribute__((section(".textlate"))) u32 bits_sign_extend_n(u32 value, u32 n)
{
    u32 bit = 1u << n;
    if (value > (bit >> 1) - 1u)
        return value - bit;
    return value;
}

/* hwd_phy__get_883b80 (0x8d2cf4, 28 Б): читает снапшот RSSI/PHY 0x883bec,
 * извлекает 11-битное поле [20:10] и знаково расширяет (n=0xb). */
__attribute__((section(".textlate"))) int hwd_phy_get_883b80(void)
{
    u32 v = (MMIO32(PHY_RX_RSSI_ADC_LOCKED) >> 10) & 0x7ffu;
    return (s16)bits_sign_extend_n(v, 0xb);
}
