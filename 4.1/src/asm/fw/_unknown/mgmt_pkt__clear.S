/* mgmt_pkt__clear @ 0x8c953c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_pkt__release
 * Зовёт сам: __ld_r13_ret, memset0_words
 */
	.section .text.mgmt_pkt__clear,"ax",@progbits
	.global mgmt_pkt__clear
mgmt_pkt__clear:
	.global L_8c953c
L_8c953c:
	push_s blink
L_8c953e:
	push_s r13
L_8c9540:
	mov.f r13,r1
L_8c9544:
	beq_s L_8c9558
L_8c9546:
	ld_s r0,[r13]
L_8c9548:
	brne r0,0x1,L_8c9558
L_8c954c:
	mov_s r0,r13
L_8c954e:
	bl.d L_8c1a78
L_8c9552:
	mov_s r1,0xd4
L_8c9554:
	mov_s r0,0x0
L_8c9556:
	st_s r0,[r13]
	.global L_8c9558
L_8c9558:
	b L_8c033c
