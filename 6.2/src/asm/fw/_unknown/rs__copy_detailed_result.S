/* rs__copy_detailed_result @ 0x8ccb48, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_get_detailed_rs_res
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rs__copy_detailed_result
rs__copy_detailed_result:
	.global L_8ccb48
L_8ccb48:
	add_s r1,r1,0x50
L_8ccb4a:
	b.d L_8c0380
L_8ccb4e:
	mov_s r2,0x1f
