/* FWQ_TX_AVAILABILITY__init @ 0x8d9084, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FWQ_TX_AVAILABILITY::init
 * Зовут его: fwq_tx__init
 * Зовёт сам: fw_log_emit0, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global FWQ_TX_AVAILABILITY__init
FWQ_TX_AVAILABILITY__init:
	.global L_8d9084
L_8d9084:
	push_s blink
L_8d9086:
	mov_s r1,0x1018c90
L_8d908c:
	bl.d L_8dcba8
L_8d9090:
	mov_s r0,0x27
L_8d9092:
	mov_s r0,0x857044
L_8d9098:
	bl.d L_8c1cd8
L_8d909c:
	mov_s r1,0x20
L_8d909e:
	pop_s blink
L_8d90a0:
	j_s [blink]
L_8d90a2:
	nop_s
L_8d90a4:
	j_s [blink]
L_8d90a6:
	nop_s
