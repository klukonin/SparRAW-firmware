/* pbss__add_sta @ 0x8dc0a0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ADD PBSS AID %d, MAC address ADDR-%04X%08X
 * Зовут его: pbss_sta_list_update
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit3, mid__add_connection
 */
	.section .text.pbss__add_sta,"ax",@progbits
	.global pbss__add_sta
pbss__add_sta:
	.global L_8dc0a0
L_8dc0a0:
	push_s blink
L_8dc0a2:
	bl L_8c02c4
L_8dc0a6:
	mov.f r13,r1
L_8dc0aa:
	mov_s r14,r0
L_8dc0ac:
	beq_s L_8dc0f0
L_8dc0ae:
	ldb_s r0,[r13,0x5]
L_8dc0b0:
	ldb r4,[r13, 0x4]
L_8dc0b4:
	asl_s r0,r0,0x8
L_8dc0b6:
	or r4,r4,r0
L_8dc0ba:
	ldb_s r0,[r13,0x1]
L_8dc0bc:
	ldb r5,[r13]
L_8dc0c0:
	asl_s r0,r0,0x8
L_8dc0c2:
	or r5,r5,r0
L_8dc0c6:
	ldb_s r0,[r13,0x2]
L_8dc0c8:
	mov_s r2,0x100e188
L_8dc0ce:
	asl_s r0,r0,0x10
L_8dc0d0:
	or r5,r5,r0
L_8dc0d4:
	ldb_s r0,[r13,0x3]
L_8dc0d6:
	mov_s r1,0x2
L_8dc0d8:
	asl_s r0,r0,0x18
L_8dc0da:
	or r5,r5,r0
L_8dc0de:
	mov_s r0,0xb
L_8dc0e0:
	bl.d L_8ee034
L_8dc0e4:
	ldb_s r3,[r13,0x6]
L_8dc0e6:
	mov_s r1,r13
L_8dc0e8:
	ld_s r0,[r14,0xc]
L_8dc0ea:
	bl.d L_8dc03c
L_8dc0ee:
	ldb_s r2,[r13,0x6]
	.global L_8dc0f0
L_8dc0f0:
	b L_8c0334
