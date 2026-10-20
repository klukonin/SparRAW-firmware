/* mac_parser__configure @ 0x8f6d54, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_filter__write_entries, mac_parser__init, mac_parser__set_886200, mac_parser__set_886260
 * Глобалы (через gp): 0x800474
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__configure
mac_parser__configure:
	.global L_8f6d54
L_8f6d54:
	push_s blink
L_8f6d56:
	bl L_8c01e4
L_8f6d5a:
	mov_s r14,r1
L_8f6d5c:
	ld.as r1,[gp,0xbc]
L_8f6d60:
	cmp_s r1,0x0
L_8f6d62:
	mov.ne r13,r14
L_8f6d66:
	bl.d L_8df778
L_8f6d6a:
	mov.eq r13,0x1
L_8f6d6e:
	mov_s r0,0x1
L_8f6d70:
	mov_s r1,0x0
L_8f6d72:
	bl.d L_8df9e8
L_8f6d76:
	mov_s r2,0x7
L_8f6d78:
	mov_s r0,0x2
L_8f6d7a:
	mov_s r1,0x0
L_8f6d7c:
	bl.d L_8df9e8
L_8f6d80:
	mov_s r2,0x3f
L_8f6d82:
	mov_s r1,0x4102
L_8f6d88:
	bl.d L_8dfbbc
L_8f6d8c:
	mov_s r0,0x1
L_8f6d8e:
	mov_s r0,0x3
L_8f6d90:
	bl.d L_8dfbbc
L_8f6d94:
	mov r1,0x102
L_8f6d98:
	mov_s r0,r13
L_8f6d9a:
	mov_s r1,r14
L_8f6d9c:
	mov_s r2,r14
L_8f6d9e:
	mov_s r3,r14
L_8f6da0:
	bl.d L_8dfba0
L_8f6da4:
	mov_s r4,r14
L_8f6da6:
	b L_8c0254
L_8f6daa:
	nop_s
