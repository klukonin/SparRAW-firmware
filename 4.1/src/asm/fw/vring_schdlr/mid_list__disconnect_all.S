/* mid_list__disconnect_all @ 0x8c7a60, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__wmi_disconnect_log, wmi_handler_disconnect_log
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, iter__has_more, iter__init, iter__next, mid__disconnect_cmd, u_schd__add
 */
	.section .text.mid_list__disconnect_all,"ax",@progbits
	.global mid_list__disconnect_all
mid_list__disconnect_all:
	.global L_8c7a60
L_8c7a60:
	push_s blink
L_8c7a62:
	bl L_8c02b8
L_8c7a66:
	sub_s sp,sp,0x4
L_8c7a68:
	mov_s r15,r0
L_8c7a6a:
	mov_s r17,r1
L_8c7a6c:
	mov_s r16,r2
L_8c7a6e:
	mov_s r14,sp
L_8c7a70:
	add r1,r0,0x18
L_8c7a74:
	bl.d L_8e1138
L_8c7a78:
	mov_s r0,r14
L_8c7a7a:
	mov_s r13,0x0
L_8c7a7c:
	b_s L_8c7a92
	.global L_8c7a7e
L_8c7a7e:
	bl.d L_8db188
L_8c7a82:
	mov_s r0,r14
L_8c7a84:
	mov_s r1,r0
L_8c7a86:
	mov_s r0,r15
L_8c7a88:
	mov_s r2,r17
L_8c7a8a:
	bl.d L_8c7c3c
L_8c7a8e:
	mov_s r3,r16
L_8c7a90:
	mov_s r13,r0
	.global L_8c7a92
L_8c7a92:
	bl.d L_8cb674
L_8c7a96:
	mov_s r0,r14
L_8c7a98:
	brne_s r0,0,L_8c7a7e
L_8c7a9a:
	brne_s r13,0,L_8c7aac
L_8c7a9c:
	mov_s r0,0x2e8a0
L_8c7aa2:
	mov_s r1,0x0
L_8c7aa4:
	mov_s r2,r1
L_8c7aa6:
	bl.d L_8c2ac8
L_8c7aaa:
	mov_s r3,0x1
	.global L_8c7aac
L_8c7aac:
	b.d L_8c031c
L_8c7ab0:
	add_s sp,sp,0x4
L_8c7ab2:
	nop_s
