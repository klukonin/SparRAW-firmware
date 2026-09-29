/* mac_icr__read_cause_887030 @ 0x8dd8c4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_vec11__ack_mac_icr2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_icr__read_cause_887030
mac_icr__read_cause_887030:
	.global L_8dd8c4
L_8dd8c4:
	mov_s r0,0x887000
L_8dd8ca:
	ld_s r0,[r0,0x30]
L_8dd8cc:
	j_s [blink]
L_8dd8ce:
	nop_s
