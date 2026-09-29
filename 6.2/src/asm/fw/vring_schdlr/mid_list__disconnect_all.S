/* mid_list__disconnect_all @ 0x8c9110, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_main_sm__action_step, vring_schd__disconnect_notify
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, iter__init, iter__next, list__has_items, mid__disconnect_cmd, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_list__disconnect_all
mid_list__disconnect_all:
	.global L_8c9110
L_8c9110:
	push_s blink
L_8c9112:
	bl L_8c01d8
L_8c9116:
	sub_s sp,sp,0x4
L_8c9118:
	mov_s r15,r0
L_8c911a:
	mov_s r17,r1
L_8c911c:
	mov_s r16,r2
L_8c911e:
	mov_s r14,sp
L_8c9120:
	add r1,r0,0x18
L_8c9124:
	bl.d L_8e5df4
L_8c9128:
	mov_s r0,r14
L_8c912a:
	mov_s r13,0x0
L_8c912c:
	b_s L_8c9142
	.global L_8c912e
L_8c912e:
	bl.d L_8df438
L_8c9132:
	mov_s r0,r14
L_8c9134:
	mov_s r1,r0
L_8c9136:
	mov_s r0,r15
L_8c9138:
	mov_s r2,r17
L_8c913a:
	bl.d L_8c9360
L_8c913e:
	mov_s r3,r16
L_8c9140:
	mov_s r13,r0
	.global L_8c9142
L_8c9142:
	bl.d L_8cdcb8
L_8c9146:
	mov_s r0,r14
L_8c9148:
	brne_s r0,0,L_8c912e
L_8c914a:
	brne_s r13,0,L_8c915c
L_8c914c:
	mov_s r0,0x36c44
L_8c9152:
	mov_s r1,0x0
L_8c9154:
	mov_s r2,r1
L_8c9156:
	bl.d L_8c3248
L_8c915a:
	mov_s r3,0x1
	.global L_8c915c
L_8c915c:
	b.d L_8c023c
L_8c9160:
	add_s sp,sp,0x4
L_8c9162:
	nop_s
