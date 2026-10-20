/* rf_kill__unmask_irq @ 0x8c1604, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_kill__irq_task, rf_kill_sm__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_kill__unmask_irq
rf_kill__unmask_irq:
	.global L_8c1604
L_8c1604:
	push_s blink
L_8c1606:
	mov_s r0,0x880b00
L_8c160c:
	st 0x8000000,[r0, 0x64]
L_8c1614:
	sync
L_8c1618:
	pop_s blink
L_8c161a:
	j_s [blink]
