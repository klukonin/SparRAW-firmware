/* brp_rf__store_module_byte @ 0x9213c0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: config_brp_rf
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_rf__store_module_byte
brp_rf__store_module_byte:
	.global L_9213c0
L_9213c0:
	ldb.x r2,[gp, -0xfa]
L_9213c4:
	add r1,r0,0x801523
L_9213cc:
	j_s.d [blink]
L_9213ce:
	stb_s r2,[r1]
