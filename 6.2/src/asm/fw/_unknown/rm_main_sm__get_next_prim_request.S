/* rm_main_sm__get_next_prim_request @ 0x8cc5a8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::get_next_prim_request. Next request is type = %d. Handle:0x%x
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, rm_main_sm__lock_primary, rm_req__get_next
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__get_next_prim_request
rm_main_sm__get_next_prim_request:
	.global L_8cc5a8
L_8cc5a8:
	push_s blink
L_8cc5aa:
	bl L_8c01e4
L_8cc5ae:
	mov_s r13,r0
L_8cc5b0:
	bl.d L_8cc65c
L_8cc5b4:
	ld_s r0,[r0,0x8]
L_8cc5b6:
	mov.f r14,r0
L_8cc5ba:
	beq_s L_8cc5dc
L_8cc5bc:
	ldb_s r0,[r13,0x3]
L_8cc5be:
	ld_s r2,[r14,0x14]
L_8cc5c0:
	breq_s r0,0,L_8cc5d0
L_8cc5c2:
	mov_s r1,0x101923c
L_8cc5c8:
	mov_s r0,0x28
L_8cc5ca:
	bl.d L_8dcc80
L_8cc5ce:
	mov_s r3,r14
	.global L_8cc5d0
L_8cc5d0:
	ld_s r0,[r14,0x14]
L_8cc5d2:
	cmp_s r0,0x0
L_8cc5d4:
	bl.eq.d L_8dc9a4
L_8cc5d8:
	mov.eq r0,r13
	.global L_8cc5dc
L_8cc5dc:
	b L_8c0254
