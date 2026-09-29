/* obj_vt8030e0__ctor @ 0x8c179c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_handler_ptrs
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__bind_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt8030e0__ctor
obj_vt8030e0__ctor:
	.global L_8c179c
L_8c179c:
	push_s blink
L_8c179e:
	push_s r13
L_8c17a0:
	mov_s r1,0x8030e0
L_8c17a6:
	bl.d L_8d94e0
L_8c17aa:
	mov_s r13,r0
L_8c17ac:
	mov_s r0,0x1
L_8c17ae:
	b.d L_8c025c
L_8c17b2:
	stb_s r0,[r13,0x3]
