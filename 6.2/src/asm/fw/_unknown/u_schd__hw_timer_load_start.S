/* u_schd__hw_timer_load_start @ 0x8e9178, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: field_set_0x00__8d8db8
 * Зовёт сам: irq_ack_880b00
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__hw_timer_load_start
u_schd__hw_timer_load_start:
	.global L_8e9178
L_8e9178:
	mov_s r1,0x880200
L_8e917e:
	st_s r0,[r1,0x48]
L_8e9180:
	mov_s r0,0x65
L_8e9182:
	st_s r0,[r1,0x58]
L_8e9184:
	sync
L_8e9188:
	b.d L_8e9190
L_8e918c:
	mov_s r0,0x1
L_8e918e:
	nop_s
