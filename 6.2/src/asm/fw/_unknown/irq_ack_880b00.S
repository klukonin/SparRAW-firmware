/* irq_ack_880b00 @ 0x8e9190, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__hw_timer_load_start, u_schd__irq_ack_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global irq_ack_880b00
irq_ack_880b00:
	.global L_8e9190
L_8e9190:
	mov_s r1,0x880b00
L_8e9196:
	mov_s r2,0x4
L_8e9198:
	breq_s r0,0,L_8e91a0
L_8e919a:
	st_s r2,[r1,0x50]
L_8e919c:
	st_s r2,[r1,0x64]
L_8e919e:
	b_s L_8e91a2
	.global L_8e91a0
L_8e91a0:
	st_s r2,[r1,0x60]
	.global L_8e91a2
L_8e91a2:
	j_s [blink]
