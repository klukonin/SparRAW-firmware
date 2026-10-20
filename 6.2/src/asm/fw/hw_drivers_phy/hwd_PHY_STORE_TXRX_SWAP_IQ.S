/* hwd_PHY_STORE_TXRX_SWAP_IQ @ 0x8d2d10, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_PHY_STORE_TXRX_SWAP_IQ  g_default_tx_swap_iq=%d, g_default_rx_swap_iq=%d
 * Зовут его: UT_HW_DRIVERS_cmd_handler, fw_main
 * Зовёт сам: fw_log_emit2
 * Глобалы (через gp): 0x800260, 0x800264
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_PHY_STORE_TXRX_SWAP_IQ
hwd_PHY_STORE_TXRX_SWAP_IQ:
	.global L_8d2d10
L_8d2d10:
	mov_s r0,0x884000
L_8d2d16:
	ld_s r2,[r0,0x28]
L_8d2d18:
	mov_s r1,0x101d900
L_8d2d1e:
	cmp_s r2,0x3
L_8d2d20:
	mov_s r2,0x1
L_8d2d22:
	sub_s.ne r2,r2,r2
L_8d2d24:
	st.as r2,[gp,0x38]
L_8d2d28:
	mov_s r0,0x883000
L_8d2d2e:
	ld_s r3,[r0,0x38]
L_8d2d30:
	cmp_s r3,0x3
L_8d2d32:
	mov_s r3,0x1
L_8d2d34:
	sub_s.ne r3,r3,r3
L_8d2d36:
	st.as r3,[gp,0x37]
L_8d2d3a:
	b.d L_8dcc80
L_8d2d3e:
	mov_s r0,0x21
