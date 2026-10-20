/* sta__set_tx_sector @ 0x93d180, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__handle_ppdu_report, set_selected_rf_sector_index_cmd_handler, sls__rx_ssw_frame
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, rf__update_active_antenna
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta__set_tx_sector
sta__set_tx_sector:
	.global L_93d180
L_93d180:
	push_s blink
L_93d182:
	bl L_920228
L_93d186:
	mov_s r15,r0
L_93d188:
	mov_s r14,r1
L_93d18a:
	mov_s r16,r2
L_93d18c:
	mov_s r17,r3
L_93d18e:
	mov_s r13,0x8021b8
L_93d194:
	ld_s r2,[r13,0x10]
L_93d196:
	asl_s r1,r15,0x4
L_93d198:
	add2_s r1,r1,r1
L_93d19a:
	add_s r1,r1,0x801104
L_93d1a0:
	ld_s r0,[gp,-0xc]
L_93d1a2:
	or r3,r0,0x30
L_93d1a6:
	breq_s r2,0,L_93d1b4
L_93d1a8:
	ldb_s r0,[r13,0x14]
L_93d1aa:
	asl r2,r0,0x8
L_93d1ae:
	or_s r2,r2,r3
L_93d1b0:
	st_s r2,[r1,0x8]
L_93d1b2:
	b_s L_93d1c0
	.global L_93d1b4
L_93d1b4:
	asl r0,r14,0x8
L_93d1b8:
	or_s r0,r0,r3
L_93d1ba:
	st_s r0,[r1,0x8]
L_93d1bc:
	extb_s r0,r14
L_93d1be:
	stb_s r14,[r13,0x14]
	.global L_93d1c0
L_93d1c0:
	bl.d L_9238cc
L_93d1c4:
	mov_s r1,0x40
L_93d1c6:
	ldb_s r1,[r13,0x14]
L_93d1c8:
	mov_s r0,0x802110
L_93d1ce:
	stb_s r1,[r0]
L_93d1d0:
	brne r17,0x1,L_93d1e6
L_93d1d4:
	mul64 r15,0x3c
L_93d1d8:
	add r0,mlo,0x857a00
L_93d1e0:
	stb_s r14,[r0]
L_93d1e2:
	stb r16,[r0, 0x1]
	.global L_93d1e6
L_93d1e6:
	b L_92028c
L_93d1ea:
	nop_s
