/* vring_schdlr__assert_line @ 0x8dcc34, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.vring_schdlr__assert_line,"ax",@progbits
	.global vring_schdlr__assert_line
vring_schdlr__assert_line:
	.byte 0x8f
	.byte 0xf1
	.global sub_8dcc36
sub_8dcc36:
	.global L_8dcc36
L_8dcc36:
	mov_s r0,blink
L_8dcc38:
	mov_s r2,0x100a584
L_8dcc3e:
	mov_s r1,0x12bd
L_8dcc44:
	bl.d L_8c82c0
L_8dcc48:
	mov r3,0x27e
