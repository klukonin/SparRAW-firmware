/* isr_timer0 @ 0x8da014, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global isr_timer0
isr_timer0:
	.global L_8da014
L_8da014:
	push_s r0
L_8da016:
	push_s r1
L_8da018:
	push_s r2
L_8da01a:
	mov_s r1,0x800948
L_8da020:
	ld_s r2,[r1,0xc]
L_8da022:
	ld_s r0,[r1,0x4]
L_8da024:
	sr r2,[r0]
L_8da028:
	ld_s r0,[r1,0x10]
L_8da02a:
	sr 0x0,[r0]
L_8da032:
	pop_s r2
L_8da034:
	pop_s r1
L_8da036:
	pop_s r0
L_8da038:
	j.f [ilink1]
