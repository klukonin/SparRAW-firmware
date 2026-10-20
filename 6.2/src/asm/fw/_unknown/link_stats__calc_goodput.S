/* link_stats__calc_goodput @ 0x8c5468, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_divmod_unsigned, mac_tx_cnt__get_fail, mac_tx_cnt__get_ok
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats__calc_goodput
link_stats__calc_goodput:
	.global L_8c5468
L_8c5468:
	push_s blink
L_8c546a:
	bl L_8c01d8
L_8c546e:
	mov_s r13,r0
L_8c5470:
	mov_s r14,r1
L_8c5472:
	mov_s r16,r2
L_8c5474:
	ld_s r15,[r0,0x2c]
L_8c5476:
	bl.d L_8dd758
L_8c547a:
	ld r17,[r0, 0x30]
L_8c547e:
	bl.d L_8dd760
L_8c5482:
	st_s r0,[r13,0x2c]
L_8c5484:
	st_s r0,[r13,0x30]
L_8c5486:
	ld_s r13,[r13,0x2c]
L_8c5488:
	sub r0,r0,r17
L_8c548c:
	sub_s r13,r13,r15
L_8c548e:
	add.f r13,r13,r0
L_8c5492:
	mov.eq r0,0xffffffff
L_8c549a:
	beq_s L_8c54a8
L_8c549c:
	mulu64 r0,0x64
L_8c54a0:
	mov_s r0,mlo
L_8c54a2:
	bl.d L_8c02d4
L_8c54a6:
	mov_s r1,r13
	.global L_8c54a8
L_8c54a8:
	st_s r0,[r14]
L_8c54aa:
	b.d L_8c023c
L_8c54ae:
	st r13,[r16]
L_8c54b2:
	nop_s
