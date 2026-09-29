/* hwd_PHY_STORE_TXRX_SWAP_IQ @ 0x8cfef4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_PHY_STORE_TXRX_SWAP_IQ  g_default_tx_swap_iq=%d, g_default_rx_swap_iq=%d
 * Зовут его: UT_HW_DRIVERS_cmd_handler, WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r13_ret, fw_log__emit2
 * Глобалы (через gp): 0x800248, 0x80024c
 */
	.section .text.hwd_PHY_STORE_TXRX_SWAP_IQ,"ax",@progbits
	.global hwd_PHY_STORE_TXRX_SWAP_IQ
hwd_PHY_STORE_TXRX_SWAP_IQ:
	.global L_8cfef4
L_8cfef4:
	push_s blink
L_8cfef6:
	push_s r13
L_8cfef8:
	mov_s r0,0x884000
L_8cfefe:
	ld_s r3,[r0,0x28]
L_8cff00:
	mov_s r2,0x10186fc
L_8cff06:
	cmp_s r3,0x3
L_8cff08:
	mov_s r3,0x1
L_8cff0a:
	sub_s.ne r3,r3,r3
L_8cff0c:
	st.as r3,[gp,0x37]
L_8cff10:
	mov_s r0,0x883000
L_8cff16:
	ld_s r13,[r0,0x38]
L_8cff18:
	mov_s r1,0x2
L_8cff1a:
	cmp_s r13,0x3
L_8cff1c:
	mov_s r13,0x1
L_8cff1e:
	sub_s.ne r13,r13,r13
L_8cff20:
	st.as r13,[gp,0x36]
L_8cff24:
	mov_s r0,0x1
L_8cff26:
	bl.d L_8edff8
L_8cff2a:
	mov_s r4,r13
L_8cff2c:
	b L_8c033c
