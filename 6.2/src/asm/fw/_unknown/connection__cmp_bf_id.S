/* connection__cmp_bf_id @ 0x8e75a4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__update_bf_id_on_rs_done, connection__bf_notify_entry, connection__on_bf_result
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 * Глобалы (через gp): 0x80025b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global connection__cmp_bf_id
connection__cmp_bf_id:
	.global L_8e75a4
L_8e75a4:
	push_s blink
L_8e75a6:
	bl.d L_8c01e0
L_8e75aa:
	mov_s r3,r0
L_8e75ac:
	ldb r0,[r0, 0x6c]
L_8e75b0:
	ldb r2,[gp, 0xd7]
L_8e75b4:
	breq r0,r2,L_8e75c0
L_8e75b8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e75ba:
	extb_s r0,r0
L_8e75bc:
	stb r0,[r3, 0x6c]
	.global L_8e75c0
L_8e75c0:
	ld_s r15,[r3,0x68]
L_8e75c2:
	add3 r2,r3,0x8
L_8e75c6:
	ldb_s r13,[r2,0x14]
L_8e75c8:
	add_s r15,r15,r1
L_8e75ca:
	add_s r14,r2,r13
L_8e75cc:
	ldb_s r0,[r14,0x15]
L_8e75ce:
	stb_s r1,[r14,0x15]
L_8e75d0:
	sub_s r15,r15,r0
L_8e75d2:
	st_s r15,[r3,0x68]
L_8e75d4:
	ldb_s r0,[gp,0xd7]
L_8e75d6:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e75d8:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e75da:
	and_s r0,r0,r13
L_8e75dc:
	stb_s r0,[r2,0x14]
L_8e75de:
	add r3,r3,0x18e
L_8e75e2:
	b.d L_8c024c
L_8e75e6:
	stb_s r1,[r3]
