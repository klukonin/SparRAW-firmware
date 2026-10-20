/* get_reg_880a7c_8d74c8 @ 0x8d74c8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: check_rf_boardfile, rf_comm_test
 */
	.section .text.get_reg_880a7c_8d74c8,"ax",@progbits
	.global get_reg_880a7c_8d74c8
get_reg_880a7c_8d74c8:
	.global L_8d74c8
L_8d74c8:
	mov_s r0,0x880a7c
L_8d74ce:
	ldw_s r0,[r0,0x12]
L_8d74d0:
	cmp_s r0,0x1
L_8d74d2:
	mov_s r0,0x1
L_8d74d4:
	j_s.d [blink]
L_8d74d6:
	sub_s.ne r0,r0,r0
