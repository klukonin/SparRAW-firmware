/* isr_timer0 @ 0x8d6f24, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.isr_timer0,"ax",@progbits
	.global isr_timer0
isr_timer0:
L_8d6f24:
	push_s r0
L_8d6f26:
	push_s r1
L_8d6f28:
	push_s r2
L_8d6f2a:
	mov_s r1,0x800888
L_8d6f30:
	ld_s r2,[r1,0xc]
L_8d6f32:
	ld_s r0,[r1,0x4]
L_8d6f34:
	sr r2,[r0]
L_8d6f38:
	ld_s r0,[r1,0x10]
L_8d6f3a:
	sr 0x0,[r0]
L_8d6f42:
	pop_s r2
L_8d6f44:
	pop_s r1
L_8d6f46:
	pop_s r0
L_8d6f48:
	j.f [ilink1]
