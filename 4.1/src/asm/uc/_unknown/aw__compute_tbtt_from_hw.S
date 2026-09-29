/* aw__compute_tbtt_from_hw @ 0x9325ac, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__set_new_tbtt
 * Зовёт сам: mac__read_pair64_consistent
 */
	.section .text.aw__compute_tbtt_from_hw,"ax",@progbits
	.global aw__compute_tbtt_from_hw
aw__compute_tbtt_from_hw:
	.global L_9325ac
L_9325ac:
	mov r8,blink
L_9325b0:
	bl.d L_93257c
L_9325b4:
	mov r7,r1
L_9325b8:
	ld r3,[0x886d64]
L_9325c0:
	mov_s r1,0x0
L_9325c2:
	extw_s r3,r3
L_9325c4:
	ld r2,[r7]
L_9325c8:
	asl_s r3,r3,0xa
L_9325ca:
	add.f r2,r2,r3
L_9325ce:
	ld r0,[r7, 0x4]
L_9325d2:
	mov blink,r8
L_9325d6:
	adc r0,r0,r1
L_9325da:
	st r2,[r7]
L_9325de:
	j_s.d [blink]
L_9325e0:
	st r0,[r7, 0x4]
