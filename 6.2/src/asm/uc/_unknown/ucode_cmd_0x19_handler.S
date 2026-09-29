/* ucode_cmd_0x19_handler @ 0x93a7a0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: bits__uc_set32_s4_w4, bits__uc_set32_s8_w15, rx_mode__bits_uc_set32_s0_w4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x19_handler
ucode_cmd_0x19_handler:
	.global L_93a7a0
L_93a7a0:
	push_s blink
L_93a7a2:
	mov_s r2,r0
L_93a7a4:
	mov_s r0,0x0
L_93a7a6:
	push_s r0
L_93a7a8:
	ldw_s r1,[r2,0x2]
L_93a7aa:
	mov_s r0,sp
L_93a7ac:
	bmsk_s r1,r1,0xe
L_93a7ae:
	bl L_93e414
L_93a7b2:
	ldb_s r1,[r2]
L_93a7b4:
	bmsk_s r1,r1,0x3
L_93a7b6:
	bl L_93e39c
L_93a7ba:
	mov_s r1,0x2
L_93a7bc:
	bl L_93e3f0
L_93a7c0:
	ld_s r0,[sp,0x0]
L_93a7c2:
	mov_s r1,0x801024
L_93a7c8:
	st_s r0,[r1]
L_93a7ca:
	mov_s r0,0x1
L_93a7cc:
	st_s r0,[r1,0x8]
L_93a7ce:
	add_s sp,sp,0x4
L_93a7d0:
	pop_s blink
L_93a7d2:
	j_s [blink]
