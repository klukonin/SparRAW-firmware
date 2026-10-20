/* vring_is_empty @ 0x8d16f0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_is_empty: sw_head:0x%x, sw_tail:0x%x
 * Зовут его: l2mgr__vring_drained
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2
 */
	.section .text.vring_is_empty,"ax",@progbits
	.global vring_is_empty
vring_is_empty:
	.global L_8d16f0
L_8d16f0:
	push_s blink
L_8d16f2:
	bl.d L_8c02c4
L_8d16f6:
	asl_s r0,r0,0x8
L_8d16f8:
	add r2,r0,0x440c0c0
L_8d1700:
	lsr_s r2,r2,0x3
L_8d1702:
	bic r2,r2,0x3
L_8d1706:
	ld_s r13,[r2]
L_8d1708:
	add_s r0,r0,0x440c100
L_8d170e:
	lsr_s r0,r0,0x3
L_8d1710:
	bic r0,r0,0x3
L_8d1714:
	ld_s r14,[r0]
L_8d1716:
	breq_s r1,0,L_8d172a
L_8d1718:
	mov_s r2,0x1018570
L_8d171e:
	mov_s r0,0x0
L_8d1720:
	mov_s r1,0x2
L_8d1722:
	mov_s r3,r13
L_8d1724:
	bl.d L_8edff8
L_8d1728:
	mov_s r4,r14
	.global L_8d172a
L_8d172a:
	cmp_s r13,r14
L_8d172c:
	mov_s r0,0x1
L_8d172e:
	b.d L_8c0334
L_8d1732:
	sub_s.ne r0,r0,r0
