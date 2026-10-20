/* rf_kill__ack_irq @ 0x8c0744, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_kill__irq_task, rf_kill_sm__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_kill__ack_irq
rf_kill__ack_irq:
	.global L_8c0744
L_8c0744:
	push_s blink
L_8c0746:
	mov_s r0,0x880b00
L_8c074c:
	st 0x8000000,[r0, 0x50]
L_8c0754:
	sync
L_8c0758:
	pop_s blink
L_8c075a:
	j_s [blink]
