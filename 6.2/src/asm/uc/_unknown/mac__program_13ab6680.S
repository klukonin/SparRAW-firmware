/* mac__program_13ab6680 @ 0x93c8e0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot_uc__init_g800610, mac_mode__switch_sequence
 * Зовёт сам: uc_timer__start
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_13ab6680
mac__program_13ab6680:
	.global L_93c8e0
L_93c8e0:
	push_s blink
L_93c8e2:
	mov_s r0,0x1
L_93c8e4:
	mov_s r1,0x0
L_93c8e6:
	mov_s r2,0x13ab6680
L_93c8ec:
	bl.d L_937354
L_93c8f0:
	mov_s r3,0x2
L_93c8f2:
	mov_s r0,0x0
L_93c8f4:
	mov_s r1,0x0
L_93c8f6:
	mov r2,0x672
L_93c8fa:
	bl.d L_937354
L_93c8fe:
	mov_s r3,0x1
L_93c900:
	pop_s blink
L_93c902:
	j_s [blink]
