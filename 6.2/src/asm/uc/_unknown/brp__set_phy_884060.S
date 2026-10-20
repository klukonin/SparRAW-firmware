/* brp__set_phy_884060 @ 0x929ee0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__tx_request, brp_responder_transmission_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__set_phy_884060
brp__set_phy_884060:
	.global L_929ee0
L_929ee0:
	st r0,[0x884060]
L_929ee8:
	j_s [blink]
L_929eea:
	nop_s
