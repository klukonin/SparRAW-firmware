/* boot_uc__init_tail @ 0x9215b8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot_uc__init_g800610
 * Зовёт сам: bf_pending__clear_bit, bf_sm__process_request_fifo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global boot_uc__init_tail
boot_uc__init_tail:
	.global L_9215b8
L_9215b8:
	b_s L_9215d2
L_9215ba:
	bl.d L_921750
L_9215be:
	mov_s r0,0x1
L_9215c0:
	bl L_921d50
