/* ucode_cmd_0x11_handler @ 0x934b94, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: memcpy_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x11_handler
ucode_cmd_0x11_handler:
	.global L_934b94
L_934b94:
	mov_s r1,r0
L_934b96:
	mov_s r0,0x8025dc
L_934b9c:
	b.d L_920330
L_934ba0:
	mov_s r2,0x20
L_934ba2:
	nop_s
