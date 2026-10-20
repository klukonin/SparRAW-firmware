/* FWQ_TX_AVAILABILITY__init @ 0x8d5f68, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FWQ_TX_AVAILABILITY::init
 * Зовут его: fwq_tx__init
 * Зовёт сам: fw_log__emit0, memset0_words
 */
	.section .text.FWQ_TX_AVAILABILITY__init,"ax",@progbits
	.global FWQ_TX_AVAILABILITY__init
FWQ_TX_AVAILABILITY__init:
	.global L_8d5f68
L_8d5f68:
	push_s blink
L_8d5f6a:
	mov_s r2,0x1015890
L_8d5f70:
	mov_s r0,0x7
L_8d5f72:
	bl.d L_8edfb0
L_8d5f76:
	mov_s r1,0x2
L_8d5f78:
	mov_s r0,0x85705c
L_8d5f7e:
	bl.d L_8c1a78
L_8d5f82:
	mov_s r1,0x20
L_8d5f84:
	pop_s blink
L_8d5f86:
	j_s [blink]
L_8d5f88:
	j_s [blink]
L_8d5f8a:
	nop_s
