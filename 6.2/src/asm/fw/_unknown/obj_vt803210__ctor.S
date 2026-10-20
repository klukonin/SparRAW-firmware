/* obj_vt803210__ctor @ 0x8d8c1c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_mgr__init_pool_and_sm
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__bind_descriptor, field_set_0x08__8d8eb4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt803210__ctor
obj_vt803210__ctor:
	.global L_8d8c1c
L_8d8c1c:
	push_s blink
L_8d8c1e:
	push_s r13
L_8d8c20:
	mov_s r13,r0
L_8d8c22:
	st_s r1,[r0,0xc]
L_8d8c24:
	st_s r2,[r0,0x8]
L_8d8c26:
	st 0xffff,[r0, 0x88]
L_8d8c2e:
	mov_s r0,0x0
L_8d8c30:
	st r0,[r13, 0x8c]
L_8d8c34:
	add r0,r13,0x10
L_8d8c38:
	bl.d L_8d8eb4
L_8d8c3c:
	mov_s r1,r13
L_8d8c3e:
	mov_s r1,0x803210
L_8d8c44:
	bl.d L_8d94e0
L_8d8c48:
	mov_s r0,r13
L_8d8c4a:
	b L_8c025c
L_8d8c4e:
	nop_s
