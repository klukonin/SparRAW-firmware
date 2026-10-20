/* pbss__add_sta @ 0x8e01a4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ADD PBSS AID %d, MAC address ADDR-%04X%08X
 * Зовут его: pbss_sta_list_update
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit3, pbss__alloc_sta_entry
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pbss__add_sta
pbss__add_sta:
	.global L_8e01a4
L_8e01a4:
	push_s blink
L_8e01a6:
	bl L_8c01e4
L_8e01aa:
	mov.f r13,r1
L_8e01ae:
	mov_s r14,r0
L_8e01b0:
	beq_s L_8e01ee
L_8e01b2:
	ldb_s r0,[r13,0x5]
L_8e01b4:
	ldb_s r3,[r13,0x4]
L_8e01b6:
	asl_s r0,r0,0x8
L_8e01b8:
	or_s r3,r3,r0
L_8e01ba:
	ldb_s r0,[r13,0x1]
L_8e01bc:
	ldb r4,[r13]
L_8e01c0:
	asl_s r0,r0,0x8
L_8e01c2:
	or r4,r4,r0
L_8e01c6:
	ldb_s r0,[r13,0x2]
L_8e01c8:
	mov_s r1,0x100f8a4
L_8e01ce:
	asl_s r0,r0,0x10
L_8e01d0:
	or r4,r4,r0
L_8e01d4:
	ldb_s r0,[r13,0x3]
L_8e01d6:
	asl_s r0,r0,0x18
L_8e01d8:
	or r4,r4,r0
L_8e01dc:
	mov_s r0,0x2b
L_8e01de:
	bl.d L_8dcd00
L_8e01e2:
	ldb_s r2,[r13,0x6]
L_8e01e4:
	mov_s r1,r13
L_8e01e6:
	ld_s r0,[r14,0x18]
L_8e01e8:
	bl.d L_8e0148
L_8e01ec:
	ldb_s r2,[r13,0x6]
	.global L_8e01ee
L_8e01ee:
	b L_8c0254
L_8e01f2:
	nop_s
