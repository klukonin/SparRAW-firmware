/* ps_assoc_mgr__vt04 @ 0x8d8d5c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__init
 * Зовёт сам: __ld_r13_to_r13_ret, obj_vt801c30__ctor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_assoc_mgr__vt04
ps_assoc_mgr__vt04:
	.global L_8d8d5c
L_8d8d5c:
	push_s blink
L_8d8d5e:
	push_s r13
L_8d8d60:
	mov_s r13,r0
L_8d8d62:
	bl.d L_8d8d08
L_8d8d66:
	add_s r0,r0,0xc
L_8d8d68:
	mov r0,-0x1
L_8d8d6c:
	st_s r0,[r13]
L_8d8d6e:
	b.d L_8c025c
L_8d8d72:
	st_s r0,[r13,0x4]
