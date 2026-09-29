/* boot_uc__init_more @ 0x92aedc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_vector_01
 * Зовёт сам: __ld_r13_to_r13_ret, buf__fill_ff, memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global boot_uc__init_more
boot_uc__init_more:
	.global L_92aedc
L_92aedc:
	push_s blink
L_92aede:
	push_s r13
L_92aee0:
	bl.d L_92ecc8
L_92aee4:
	mov_s r13,r0
L_92aee6:
	add2 r0,r13,0x17
L_92aeea:
	bl.d L_920a84
L_92aeee:
	mov_s r1,0x50
L_92aef0:
	add2 r0,r13,0x2b
L_92aef4:
	bl.d L_920a84
L_92aef8:
	mov_s r1,0x50
L_92aefa:
	mov_s r0,0x0
L_92aefc:
	st_s r0,[r13,0x58]
L_92aefe:
	add2 r0,r13,0x15
L_92af02:
	bl.d L_920a84
L_92af06:
	mov_s r1,0x4
L_92af08:
	b L_9202ac
