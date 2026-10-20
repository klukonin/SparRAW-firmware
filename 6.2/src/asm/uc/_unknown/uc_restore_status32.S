/* uc_restore_status32 @ 0x9215c4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_restore_status32
uc_restore_status32:
	.global L_9215c4
L_9215c4:
	lr r0,[0xa]
L_9215c8:
	bic r13,r13,-0x3
L_9215cc:
	or_s r0,r0,r13
	.global L_9215ce
L_9215ce:
	.byte 0x29,0x20
