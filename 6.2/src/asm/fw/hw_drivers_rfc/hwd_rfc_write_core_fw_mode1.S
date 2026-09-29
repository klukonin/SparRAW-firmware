/* hwd_rfc_write_core_fw_mode1 @ 0x8d33ec, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, rf__configure_chain
 * Зовёт сам: hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_write_core_fw_mode1
hwd_rfc_write_core_fw_mode1:
	.global L_8d33ec
L_8d33ec:
	mov_s r1,0x1
L_8d33ee:
	mov_s r2,0x0
L_8d33f0:
	b.d L_8d415c
L_8d33f4:
	mov_s r3,r2
L_8d33f6:
	nop_s
