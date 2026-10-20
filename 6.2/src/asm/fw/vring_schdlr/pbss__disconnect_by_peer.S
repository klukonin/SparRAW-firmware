/* pbss__disconnect_by_peer @ 0x8c9164, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PBSS Disconnection: MAC-ADDR-%04X%08X
 * Зовут его: disconnect_by_peer
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn__disconnect, fw_log_emit2, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pbss__disconnect_by_peer
pbss__disconnect_by_peer:
	.global L_8c9164
L_8c9164:
	push_s blink
L_8c9166:
	bl L_8c01dc
L_8c916a:
	sub_s sp,sp,0x4
L_8c916c:
	mov_s r16,r1
L_8c916e:
	mov_s r15,r2
L_8c9170:
	mov_s r14,sp
L_8c9172:
	add r1,r0,0x18
L_8c9176:
	bl.d L_8e5df4
L_8c917a:
	mov_s r0,r14
L_8c917c:
	b_s L_8c918a
	.global L_8c917e
L_8c917e:
	bl.d L_8df438
L_8c9182:
	mov_s r0,r14
L_8c9184:
	mov_s r13,r0
L_8c9186:
	ld_s r0,[r0,0x28]
L_8c9188:
	brne_s r0,0,L_8c9198
	.global L_8c918a
L_8c918a:
	bl.d L_8cdcb8
L_8c918e:
	mov_s r0,r14
L_8c9190:
	brne_s r0,0,L_8c917e
L_8c9192:
	b.d L_8c0244
L_8c9196:
	add_s sp,sp,0x4
	.global L_8c9198
L_8c9198:
	add r3,r13,0x1c
L_8c919c:
	ldb_s r2,[r3,0x2]
L_8c919e:
	mov_s r1,0x100cc50
L_8c91a4:
	mov_s r0,0x2b
L_8c91a6:
	bl.d L_8dcc80
L_8c91aa:
	ld_s r3,[r3]
L_8c91ac:
	mov_s r0,r13
L_8c91ae:
	mov_s r1,r16
L_8c91b0:
	bl.d L_8f2540
L_8c91b4:
	mov_s r2,r15
L_8c91b6:
	b_s L_8c918a
