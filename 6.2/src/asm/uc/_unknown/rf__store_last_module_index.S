/* rf__store_last_module_index @ 0x92b174, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x0b_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf__store_last_module_index
rf__store_last_module_index:
	.global L_92b174
L_92b174:
	ldb r0,[0x85773c]
L_92b17c:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_92b17e:
	j_s.d [blink]
L_92b180:
	stb r0,[gp, -0xf7]
