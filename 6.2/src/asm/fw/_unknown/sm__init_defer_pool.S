/* sm__init_defer_pool @ 0x8d9b58, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: mem_pool__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm__init_defer_pool
sm__init_defer_pool:
	.global L_8d9b58
L_8d9b58:
	mov_s r1,0x803cd0
L_8d9b5e:
	sub r0,r1,0x14
L_8d9b62:
	mov_s r2,0x10
L_8d9b64:
	b.d L_8c7cf8
L_8d9b68:
	mov_s r3,0x4
L_8d9b6a:
	nop_s
