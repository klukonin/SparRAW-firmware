/* scan_mngr__entry_addr @ 0x8cc6a4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: scan_mngr__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__entry_addr
scan_mngr__entry_addr:
	.global L_8cc6a4
L_8cc6a4:
	asl_s r1,r0,0x2
L_8cc6a6:
	add3_s r1,r1,r1
L_8cc6a8:
	add r0,r1,0x842d00
L_8cc6b0:
	j_s [blink]
L_8cc6b2:
	nop_s
