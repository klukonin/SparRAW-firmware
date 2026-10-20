/* rf_kill__irq_task @ 0x8e2f70, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, mac__toggle_880288_b1, rf_kill__ack_irq, rf_kill__unmask_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_kill__irq_task
rf_kill__irq_task:
	.global L_8e2f70
L_8e2f70:
	push_s blink
L_8e2f72:
	push_s r13
L_8e2f74:
	mov_s r0,0x880280
L_8e2f7a:
	ld_s r0,[r0,0x8]
L_8e2f7c:
	mov_s r13,0x804c34
L_8e2f82:
	btst_s r0,0x0
L_8e2f84:
	mov_s r0,r13
L_8e2f86:
	mov_s r1,0x0
L_8e2f88:
	mov.eq r1,0x1
L_8e2f8c:
	mov_s r2,0x0
L_8e2f8e:
	mov_s r3,r2
L_8e2f90:
	bl.d L_8d9b6c
L_8e2f94:
	mov_s r4,r2
L_8e2f96:
	bl.d L_8c7044
L_8e2f9a:
	mov_s r0,r13
L_8e2f9c:
	bl L_8c0744
L_8e2fa0:
	bl L_8c1604
L_8e2fa4:
	b L_8c025c
