/* rf_kill__mask_irq @ 0x8c14bc, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr__step_22f70_80044c__8cdbb4, rf_kill_sm__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_kill__mask_irq
rf_kill__mask_irq:
	.global L_8c14bc
L_8c14bc:
	push_s blink
L_8c14be:
	mov_s r0,0x880b00
L_8c14c4:
	st 0x8000000,[r0, 0x60]
L_8c14cc:
	sync
L_8c14d0:
	pop_s blink
L_8c14d2:
	j_s [blink]
