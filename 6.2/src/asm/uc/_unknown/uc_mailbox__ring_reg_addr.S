/* uc_mailbox__ring_reg_addr @ 0x92a6dc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_mailbox__init_rings
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_mailbox__ring_reg_addr
uc_mailbox__ring_reg_addr:
	.global L_92a6dc
L_92a6dc:
	mov_s r0,0x8802bc
L_92a6e2:
	j_s [blink]
