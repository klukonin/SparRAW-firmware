/* bi_sm__action_92646c @ 0x92646c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_sm__action_92646c
bi_sm__action_92646c:
	.global L_92646c
L_92646c:
	mov_s r0,blink
L_92646e:
	mov_s r1,0x33
L_926470:
	b.d L_926618
L_926474:
	bset_s r1,r1,0xc
L_926476:
	nop_s
