/* fsched__test_mask2c_bit @ 0x92be4c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__test_mask2c_bit
fsched__test_mask2c_bit:
	.global L_92be4c
L_92be4c:
	mov_s r2,0x0
L_92be4e:
	ldb r0,[r0, 0x2c]
L_92be52:
	bset r2,r2,r1
L_92be56:
	and_s r0,r0,r2
L_92be58:
	sub.f r0,r0,0x0
L_92be5c:
	j_s.d [blink]
L_92be5e:
	mov.ne r0,0x1
L_92be62:
	nop_s
