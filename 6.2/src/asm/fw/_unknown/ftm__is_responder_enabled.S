/* ftm__is_responder_enabled @ 0x8da560, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ftm__responder_rx_req
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm__is_responder_enabled
ftm__is_responder_enabled:
	.global L_8da560
L_8da560:
	ldb r0,[r0, 0x24]
L_8da564:
	j_s.d [blink]
L_8da566:
	bmsk_s r0,r0,0x0
