/* rfc__write_field_1136 @ 0x8d4064, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rfc__restore_txrx_sets_fw
 * Зовёт сам: rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__write_field_1136
rfc__write_field_1136:
	.global L_8d4064
L_8d4064:
	extb_s r0,r0
L_8d4066:
	mov r1,0x470
L_8d406a:
	b.d L_8d4308
L_8d406e:
	mov_s r2,0x10
