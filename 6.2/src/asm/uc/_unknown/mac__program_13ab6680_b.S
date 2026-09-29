/* mac__program_13ab6680_b @ 0x93c904, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode__switch_sequence
 * Зовёт сам: uc_timer__start
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_13ab6680_b
mac__program_13ab6680_b:
	.global L_93c904
L_93c904:
	push_s blink
L_93c906:
	mov_s r0,0x1
L_93c908:
	mov_s r1,0x0
L_93c90a:
	mov_s r2,0x13ab6680
L_93c910:
	bl.d L_937354
L_93c914:
	mov_s r3,r1
L_93c916:
	mov_s r0,0x0
L_93c918:
	mov_s r1,0x0
L_93c91a:
	mov r2,0x672
L_93c91e:
	bl.d L_937354
L_93c922:
	mov_s r3,r1
L_93c924:
	pop_s blink
L_93c926:
	j_s [blink]
