/* wait_sm__init @ 0x8d8e24, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: obj_vt80296c__ctor
 * Зовёт сам: basic_sm__bind_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wait_sm__init
wait_sm__init:
	.global L_8d8e24
L_8d8e24:
	mov_s r2,0x0
L_8d8e26:
	st_s r1,[r0,0x10]
L_8d8e28:
	mov_s r1,0x802ba0
L_8d8e2e:
	b.d L_8d94e0
L_8d8e32:
	stb_s r2,[r0,0x8]
