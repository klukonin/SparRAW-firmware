/* vring__enable_first_pending_gtk @ 0x8cd0a4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   GTK key_id: %d.
 * Зовут его: return_field_type
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, mid_list__by_obj_mid, ut_hw_cmd_0x008, vring__send_en_evt_u8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__enable_first_pending_gtk
vring__enable_first_pending_gtk:
	.global L_8cd0a4
L_8cd0a4:
	push_s blink
L_8cd0a6:
	bl L_8c01e0
L_8cd0aa:
	mov_s r13,0x0
L_8cd0ac:
	b_s L_8cd0b0
	.global L_8cd0ae
L_8cd0ae:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8cd0b0
L_8cd0b0:
	brhs r13,0xa,L_8cd100
L_8cd0b4:
	mov_s r0,0x847f34
L_8cd0ba:
	sub r0,r0,0x400
L_8cd0be:
	add2_s r0,r0,r13
L_8cd0c0:
	ld r14,[r0,0x44c]
L_8cd0c8:
	breq_s r14,0,L_8cd0ae
L_8cd0ca:
	ld_s r0,[r14,0xc]
L_8cd0cc:
	breq_s r0,0,L_8cd0ae
L_8cd0ce:
	ldb_s r0,[r14,0x7]
L_8cd0d0:
	breq r0,0x9,L_8cd0ae
L_8cd0d4:
	bl.d L_8cc41c
L_8cd0d8:
	mov_s r0,r14
L_8cd0da:
	mov_s r15,r0
L_8cd0dc:
	add r15,r15,0x294
L_8cd0e0:
	mov_s r0,r14
L_8cd0e2:
	mov_s r1,0x1
L_8cd0e4:
	bl.d L_8eacb0
L_8cd0e8:
	ldb_s r2,[r15,0x10]
L_8cd0ea:
	mov_s r1,0x1010c98
L_8cd0f0:
	mov_s r0,0x2b
L_8cd0f2:
	bl.d L_8dcc10
L_8cd0f6:
	ldb_s r2,[r15,0x10]
L_8cd0f8:
	mov_s r0,r13
L_8cd0fa:
	bl.d L_8f5a54
L_8cd0fe:
	ld_s r1,[r14,0x8]
	.global L_8cd100
L_8cd100:
	b L_8c024c
