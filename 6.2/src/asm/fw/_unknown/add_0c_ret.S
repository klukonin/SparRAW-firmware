/* add_0c_ret @ 0x8cc364, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_sysapi_get_beamforming_statistics
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global add_0c_ret
add_0c_ret:
	.global L_8cc364
L_8cc364:
	j_s.d [blink]
L_8cc366:
	add_s r0,r0,0xc
