/* vring_is_empty @ 0x8d47a0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_is_empty: sw_head:0x%x, sw_tail:0x%x
 * Зовут его: ba_sm__action_8c4394, vring__is_empty_by_id
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_is_empty
vring_is_empty:
	.global L_8d47a0
L_8d47a0:
	push_s blink
L_8d47a2:
	bl.d L_8c01e4
L_8d47a6:
	asl_s r0,r0,0x8
L_8d47a8:
	add r2,r0,0x440c0c0
L_8d47b0:
	lsr_s r2,r2,0x3
L_8d47b2:
	bic r2,r2,0x3
L_8d47b6:
	ld_s r14,[r2]
L_8d47b8:
	add_s r0,r0,0x440c100
L_8d47be:
	lsr_s r0,r0,0x3
L_8d47c0:
	bic r0,r0,0x3
L_8d47c4:
	ld_s r13,[r0]
L_8d47c6:
	breq_s r1,0,L_8d47d8
L_8d47c8:
	mov_s r1,0x101d528
L_8d47ce:
	mov_s r0,0x20
L_8d47d0:
	mov_s r2,r14
L_8d47d2:
	bl.d L_8dcc80
L_8d47d6:
	mov_s r3,r13
	.global L_8d47d8
L_8d47d8:
	cmp_s r14,r13
L_8d47da:
	mov_s r0,0x1
L_8d47dc:
	b.d L_8c0254
L_8d47e0:
	sub_s.ne r0,r0,r0
L_8d47e2:
	nop_s
