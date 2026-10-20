/* aw__compute_tbtt_from_hw @ 0x937518, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__set_new_tbtt
 * Зовёт сам: mac__read_bi_start_tsf64_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw__compute_tbtt_from_hw
aw__compute_tbtt_from_hw:
	.global L_937518
L_937518:
	mov r8,blink
L_93751c:
	bl.d L_9374e8
L_937520:
	mov r7,r1
L_937524:
	ld r3,[0x886d64]
L_93752c:
	mov_s r1,0x0
L_93752e:
	extw_s r3,r3
L_937530:
	ld r2,[r7]
L_937534:
	asl_s r3,r3,0xa
L_937536:
	add.f r2,r2,r3
L_93753a:
	ld r0,[r7, 0x4]
L_93753e:
	mov blink,r8
L_937542:
	adc r0,r0,r1
L_937546:
	st r2,[r7]
L_93754a:
	j_s.d [blink]
L_93754c:
	st r0,[r7, 0x4]
