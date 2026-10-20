/* rm_main_sm__get_next_prim_request @ 0x8ca388, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::get_next_prim_request. Next request is type = %d. Handle:0x%x
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, obj__get_field4, rm_main_sm__lock_primary
 */
	.section .text.rm_main_sm__get_next_prim_request,"ax",@progbits
	.global rm_main_sm__get_next_prim_request
rm_main_sm__get_next_prim_request:
L_8ca388:
	push_s blink
L_8ca38a:
	bl L_8c02c4
L_8ca38e:
	mov_s r13,r0
L_8ca390:
	bl.d L_8ca454
L_8ca394:
	ld_s r0,[r0,0x2c]
L_8ca396:
	mov.f r14,r0
L_8ca39a:
	beq_s L_8ca3be
L_8ca39c:
	ld_s r0,[r13,0x28]
L_8ca39e:
	ld_s r3,[r14,0x14]
L_8ca3a0:
	breq_s r0,0,L_8ca3b2
L_8ca3a2:
	mov_s r2,0x1015edc
L_8ca3a8:
	mov_s r0,0x8
L_8ca3aa:
	mov_s r1,0x2
L_8ca3ac:
	bl.d L_8edff8
L_8ca3b0:
	mov_s r4,r14
	.global L_8ca3b2
L_8ca3b2:
	ld_s r0,[r14,0x14]
L_8ca3b4:
	cmp_s r0,0x0
L_8ca3b6:
	bl.eq.d L_8d91d4
L_8ca3ba:
	mov.eq r0,r13
	.global L_8ca3be
L_8ca3be:
	.byte 0x79,0x07
