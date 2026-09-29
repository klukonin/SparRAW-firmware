/* obj_vt802744__ctor @ 0x8d8d30, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: connection__init
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__bind_descriptor, disc_flush_sm__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt802744__ctor
obj_vt802744__ctor:
	.global L_8d8d30
L_8d8d30:
	push_s blink
L_8d8d32:
	push_s r13
L_8d8d34:
	mov_s r13,r0
L_8d8d36:
	st_s r1,[r0,0x8]
L_8d8d38:
	mov_s r0,0x0
L_8d8d3a:
	st_s r0,[r13,0x2c]
L_8d8d3c:
	st_s r0,[r13,0x30]
L_8d8d3e:
	mov_s r1,0x802744
L_8d8d44:
	bl.d L_8d94e0
L_8d8d48:
	mov_s r0,r13
L_8d8d4a:
	mov_s r0,0x1
L_8d8d4c:
	stb_s r0,[r13,0x3]
L_8d8d4e:
	add r0,r13,0xc
L_8d8d52:
	bl.d L_8f5310
L_8d8d56:
	mov_s r1,r13
L_8d8d58:
	b L_8c025c
