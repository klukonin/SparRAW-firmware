/* silent_rssi__set_agc_search_window @ 0x8d49d0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__set_agc_start_val
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_phy_rx_set_agc_start_val_and_gain_array
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global silent_rssi__set_agc_search_window
silent_rssi__set_agc_search_window:
	.global L_8d49d0
L_8d49d0:
	push_s blink
L_8d49d2:
	push_s r13
L_8d49d4:
	bl.d L_8d2a6c
L_8d49d8:
	mov_s r13,r0
L_8d49da:
	mov_s r2,0x800508
L_8d49e0:
	ldb_s r0,[r2,0x8]
L_8d49e2:
	mov_s r1,0x1
L_8d49e4:
	sub r3,r13,r0
L_8d49e8:
	mov_s r0,0x1
L_8d49ea:
	cmp_s r3,0x1
L_8d49ec:
	mov.hi r0,r3
L_8d49f0:
	stb_s r0,[r2,0xa]
L_8d49f2:
	ldb_s r0,[r2,0x9]
L_8d49f4:
	add_s r0,r0,r13
L_8d49f6:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d49f8:
	cmp_s r0,0x3f
L_8d49fa:
	mov.cc r0,0x3f
L_8d49fe:
	stb_s r0,[r2,0xb]
L_8d4a00:
	b.d L_8c025c
L_8d4a04:
	st_s r1,[r2,0xc]
L_8d4a06:
	nop_s
