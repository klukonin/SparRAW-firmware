/* ba_setup_sm__assert_line @ 0x8e92c4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm.cpp
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.ba_setup_sm__assert_line,"ax",@progbits
	.global ba_setup_sm__assert_line
ba_setup_sm__assert_line:
L_8e92c4:
	add_s sp,sp,0x8
	.global sub_8e92c6
sub_8e92c6:
	.global L_8e92c6
L_8e92c6:
	mov_s r0,blink
L_8e92c8:
	mov_s r2,0x10102c4
L_8e92ce:
	mov_s r1,0x127f
L_8e92d4:
	bl.d L_8c82c0
L_8e92d8:
	mov r3,0x120
