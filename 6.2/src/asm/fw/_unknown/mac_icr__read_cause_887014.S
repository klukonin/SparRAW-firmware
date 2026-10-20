/* mac_icr__read_cause_887014 @ 0x8dd8b8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_vec10__ack_mac_icr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_icr__read_cause_887014
mac_icr__read_cause_887014:
	.global L_8dd8b8
L_8dd8b8:
	mov_s r0,0x887000
L_8dd8be:
	ld_s r0,[r0,0x14]
L_8dd8c0:
	j_s [blink]
L_8dd8c2:
	nop_s
