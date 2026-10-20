/* macq__clear_886a28_low2 @ 0x8ea450, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq__clear_886a28_low2
macq__clear_886a28_low2:
	.global L_8ea450
L_8ea450:
	push_s blink
L_8ea452:
	mov_s r1,0x886a00
L_8ea458:
	ld_s r0,[r1,0x28]
L_8ea45a:
	or r0,r0,0x3
L_8ea45e:
	st_s r0,[r1,0x28]
L_8ea460:
	sync
L_8ea464:
	mov_s r1,0x886a00
L_8ea46a:
	ld_s r0,[r1,0x28]
L_8ea46c:
	bic r0,r0,0x3
L_8ea470:
	st_s r0,[r1,0x28]
L_8ea472:
	sync
L_8ea476:
	pop_s blink
L_8ea478:
	j_s [blink]
L_8ea47a:
	nop_s
