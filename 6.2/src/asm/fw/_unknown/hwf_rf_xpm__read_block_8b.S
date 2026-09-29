/* hwf_rf_xpm__read_block_8b @ 0x8f6d0c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: otp_init
 * Зовёт сам: hwf_rf_xpm_read_block_8f4b70
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm__read_block_8b
hwf_rf_xpm__read_block_8b:
	.global L_8f6d0c
L_8f6d0c:
	mov_s r3,r0
L_8f6d0e:
	mov_s r0,0x8042c8
L_8f6d14:
	ldb_s r0,[r0]
L_8f6d16:
	mov_s r1,0x0
L_8f6d18:
	b.d L_8f4b70
L_8f6d1c:
	mov_s r2,0x8
L_8f6d1e:
	nop_s
