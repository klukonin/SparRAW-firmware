/* rng__rand_below @ 0x936de0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_update_omni_sector_idx
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rng__rand_below
rng__rand_below:
	.global L_936de0
L_936de0:
	push_s r13
L_936de2:
	mov_s r1,r0
L_936de4:
	ld r0,[0x880bc4]
L_936dec:
	brlo.d r1,0x2,L_936dfc
L_936df0:
	mov r13,blink
L_936df4:
	mulu64 r0,r1
L_936df8:
	mov r0,mhi
	.global L_936dfc
L_936dfc:
	mov_s blink,r13
L_936dfe:
	j_s.d [blink]
L_936e00:
	pop_s r13
L_936e02:
	nop_s
