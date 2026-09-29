/* hwd_phy_rx_set_agc_start_val_and_gain_array @ 0x8d2a6c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_rx_set_agc_start_val_and_gain_array(): ina_agc_gain_array=%x doesn't match ina_agc_start=%d, estimated_agc_plus_step0=%d
 *   hwd_phy_rx_set_agc_start_val_and_gain_array(): estimated_agc_plus_step1=%d, estimated_agc_plus_step2=%d, estimated_agc_plus_step3=%d
 * Зовут его: silent_rssi__set_agc_search_window, ut_hw_drivers__pair_2568
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_rx_set_agc_start_val_and_gain_array
hwd_phy_rx_set_agc_start_val_and_gain_array:
	.global L_8d2a6c
L_8d2a6c:
	push_s blink
L_8d2a6e:
	bl.d L_8c01d4
L_8d2a72:
	bmsk r4,r1,0x5
L_8d2a76:
	mov_s r14,r0
L_8d2a78:
	mov_s r13,r1
L_8d2a7a:
	and r18,r1,0xfc0
L_8d2a82:
	and r17,r1,0x3f000
L_8d2a8a:
	and r16,r1,0xfc0000
L_8d2a92:
	cmp_s r0,r4
L_8d2a94:
	cmp.ls r14,r18
L_8d2a98:
	cmp.ls r14,r17
L_8d2a9c:
	cmp.ls r14,r16
L_8d2aa0:
	bls_s L_8d2ad2
L_8d2aa2:
	mov_s r1,0x101d71c
L_8d2aa8:
	mov_s r0,0x0
L_8d2aaa:
	mov_s r2,r13
L_8d2aac:
	bl.d L_8dcd00
L_8d2ab0:
	mov_s r3,r14
L_8d2ab2:
	mov_s r1,0x101d7a0
L_8d2ab8:
	mov_s r0,0x0
L_8d2aba:
	mov_s r2,r18
L_8d2abc:
	mov_s r3,r17
L_8d2abe:
	bl.d L_8dcd00
L_8d2ac2:
	mov r4,r16
L_8d2ac6:
	mov_s r0,blink
L_8d2ac8:
	mov_s r1,0x146c
L_8d2ace:
	bl L_8c9b28
	.global L_8d2ad2
L_8d2ad2:
	mov_s r0,0x883000
L_8d2ad8:
	st.as r14,[r0,0x4b]
L_8d2adc:
	st.as r13,[r0,0x73]
L_8d2ae0:
	b L_8c0234
