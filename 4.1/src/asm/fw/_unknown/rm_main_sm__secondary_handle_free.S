/* rm_main_sm__secondary_handle_free @ 0x8e02a0, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::secondary_handle_free. Handle:0x%x, CB:0x%x
 *   rm_main_sm::secondary_handle_free. Next request:[Handle:0x%x][type:%d]
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__store_pending_event, fw_log__emit2, llist__remove, obj__get_field4, radio_mgr__free_handle
 */
	.section .text.rm_main_sm__secondary_handle_free,"ax",@progbits
	.global rm_main_sm__secondary_handle_free
rm_main_sm__secondary_handle_free:
	.byte 0x0f
	.byte 0xf0
	.global fwlog_rm_main_sm_secondary_handle_free_Next_re
fwlog_rm_main_sm_secondary_handle_free_Next_re:
L_8e02a2:
	nop_s
L_8e02a4:
	push_s blink
L_8e02a6:
	bl L_8c02c4
L_8e02aa:
	mov_s r14,r0
L_8e02ac:
	ld_s r0,[r0,0x28]
L_8e02ae:
	mov_s r13,r1
L_8e02b0:
	breq_s r0,0,L_8e02c6
L_8e02b2:
	mov_s r2,0x1015fc4
L_8e02b8:
	ld r4,[r13, 0xc]
L_8e02bc:
	mov_s r0,0x8
L_8e02be:
	mov_s r1,0x2
L_8e02c0:
	bl.d L_8edff8
L_8e02c4:
	mov_s r3,r13
	.global L_8e02c6
L_8e02c6:
	add2 r0,r14,0x31
L_8e02ca:
	bl.d L_8de4ec
L_8e02ce:
	mov_s r1,r13
L_8e02d0:
	ld_s r0,[r14,0x30]
L_8e02d2:
	bl.d L_8d9c0c
L_8e02d6:
	mov_s r1,r13
L_8e02d8:
	bl.d L_8ca454
L_8e02dc:
	ld_s r0,[r14,0x2c]
L_8e02de:
	mov.f r13,r0
L_8e02e2:
	beq_s L_8e0308
L_8e02e4:
	ld_s r0,[r14,0x28]
L_8e02e6:
	ld r4,[r13, 0x14]
L_8e02ea:
	breq_s r0,0,L_8e02fc
L_8e02ec:
	mov_s r2,0x1015ffc
L_8e02f2:
	mov_s r0,0x8
L_8e02f4:
	mov_s r1,0x2
L_8e02f6:
	bl.d L_8edff8
L_8e02fa:
	mov_s r3,r13
	.global L_8e02fc
L_8e02fc:
	ld_s r0,[r13,0x14]
L_8e02fe:
	cmp_s r0,0x1
L_8e0300:
	mov.eq r0,r14
L_8e0304:
	mov_s r1,0x6
L_8e0306:
	beq_s L_8e030c
	.global L_8e0308
L_8e0308:
	mov_s r0,r14
L_8e030a:
	mov_s r1,0x1
	.global L_8e030c
L_8e030c:
	mov_s r2,0x0
L_8e030e:
	mov_s r3,r2
L_8e0310:
	bl.d L_8e20c0
L_8e0314:
	mov_s r4,r2
L_8e0316:
	.byte 0x21,0x00
