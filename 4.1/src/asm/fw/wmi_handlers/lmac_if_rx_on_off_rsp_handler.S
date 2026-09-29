/* lmac_if_rx_on_off_rsp_handler @ 0x8caf90, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch, rx_off__complete_when_drained
 */
	.section .text.lmac_if_rx_on_off_rsp_handler,"ax",@progbits
	.global lmac_if_rx_on_off_rsp_handler
lmac_if_rx_on_off_rsp_handler:
	.global L_8caf90
L_8caf90:
	mov_s r1,r0
L_8caf92:
	ld_s r0,[gp,-0x30]
L_8caf94:
	ld_s r2,[r0]
L_8caf96:
	ld_s r2,[r2,0x28]
