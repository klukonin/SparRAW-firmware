/* ps_nonassoc_mgr__vt04 @ 0x8d8e98, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__init
 * Зовёт сам: __ld_r13_to_r13_ret, obj_vt801bec__ctor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_nonassoc_mgr__vt04
ps_nonassoc_mgr__vt04:
	.global L_8d8e98
L_8d8e98:
	push_s blink
L_8d8e9a:
	push_s r13
L_8d8e9c:
	mov_s r13,r0
L_8d8e9e:
	bl.d L_8d8e34
L_8d8ea2:
	add_s r0,r0,0xc
L_8d8ea4:
	mov_s r1,0xffffff
L_8d8eaa:
	mov_s r0,0x0
L_8d8eac:
	st_s r1,[r13]
L_8d8eae:
	b.d L_8c025c
L_8d8eb2:
	st_s r0,[r13,0x4]
