/* uc_restore_status32 @ 0x921e20, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_restore_status32,"ax",@progbits
	.global uc_restore_status32
uc_restore_status32:
	.global L_921e20
L_921e20:
	lr r0,[0xa]
L_921e24:
	bic r13,r13,-0x3
L_921e28:
	or_s r0,r0,r13
	.global L_921e2a
L_921e2a:
	.byte 0x29,0x20
