/* rfc__write_core_reg6 @ 0x8d32a4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd__setup_pair, rfc__restore_txrx_sets_fw
 * Зовёт сам: hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__write_core_reg6
rfc__write_core_reg6:
	.global L_8d32a4
L_8d32a4:
	bmsk r2,r1,0xe
L_8d32a8:
	mov_s r1,0x6
L_8d32aa:
	b.d L_8d415c
L_8d32ae:
	mov_s r3,0x0
