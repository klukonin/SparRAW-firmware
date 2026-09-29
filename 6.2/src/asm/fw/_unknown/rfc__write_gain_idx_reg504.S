/* rfc__write_gain_idx_reg504 @ 0x8e62dc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: silent_rssi__set_rf_gain_index
 * Зовёт сам: hwd_rfc_write_verify
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__write_gain_idx_reg504
rfc__write_gain_idx_reg504:
	.global L_8e62dc
L_8e62dc:
	mov_s r3,r2
L_8e62de:
	asl_s r2,r1,0x4
L_8e62e0:
	ldb_s r0,[r0]
L_8e62e2:
	mov r1,0x504
L_8e62e6:
	or_s r2,r2,r3
L_8e62e8:
	b.d L_8d4468
L_8e62ec:
	mov_s r3,0x6
L_8e62ee:
	nop_s
