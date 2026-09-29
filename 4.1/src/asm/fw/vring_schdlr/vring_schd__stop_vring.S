/* vring_schd__stop_vring @ 0x8e2ff0, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   VR_SCHDLR received STOP command for V-ring #%d.
 *   vring_schdlr.cpp
 * Зовут его: frag_8dcb2c, frag_8dcb34
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, fw_sysassert_fatal, llist__insert, llist__remove, tail_sm_pring__state_step, u_schd__add, vring__disable_and_ack, vring_list__find, vring_schd__find_by_cid
 */
	.section .text.vring_schd__stop_vring,"ax",@progbits
	.global vring_schd__stop_vring
vring_schd__stop_vring:
L_8e2ff0:
	mov_s r0,r1
	.global fwlog_VR_SCHDLR_received_STOP_command_for_V_ri
fwlog_VR_SCHDLR_received_STOP_command_for_V_ri:
L_8e2ff2:
	nop_s
	.global L_8e2ff4
L_8e2ff4:
	push_s blink
L_8e2ff6:
	bl L_8c02b8
L_8e2ffa:
	sub_s sp,sp,0x8
L_8e2ffc:
	mov_s r17,r0
L_8e2ffe:
	mov_s r2,0x100a710
L_8e3004:
	mov_s r0,0x7
L_8e3006:
	mov_s r14,0x2
L_8e3008:
	mov_s r1,r14
L_8e300a:
	bl.d L_8edfcc
L_8e300e:
	mov_s r3,r17
L_8e3010:
	mov_s r13,0x804580
L_8e3016:
	mov_s r15,sp
L_8e3018:
	add_s r3,sp,0x4
L_8e301a:
	mov_s r0,r13
L_8e301c:
	mov_s r1,r17
L_8e301e:
	bl.d L_8e72b8
L_8e3022:
	mov_s r2,r15
L_8e3024:
	brne r0,0x1,L_8e3060
L_8e3028:
	ld_s r0,[sp,0x0]
L_8e302a:
	mov_s r1,0x0
L_8e302c:
	st_s r1,[r0,0x20]
L_8e302e:
	ld_s r1,[sp,0x0]
L_8e3030:
	ld_s r0,[r1,0x24]
L_8e3032:
	brne r0,0x3,L_8e30be
L_8e3036:
	mov_s r0,0x4
L_8e3038:
	st_s r0,[r1,0x24]
L_8e303a:
	mov_s r0,r13
L_8e303c:
	bl.d L_8e2fec
L_8e3040:
	ld_s r1,[sp,0x4]
L_8e3042:
	b_s L_8e30be
	.global L_8e3044
L_8e3044:
	asl_s r1,r14,0x2
L_8e3046:
	add1_s r1,r1,r1
L_8e3048:
	add r0,r13,0xc
L_8e304c:
	add r16,r0,r1
L_8e3050:
	mov_s r0,r13
L_8e3052:
	mov_s r1,r16
L_8e3054:
	mov_s r2,r17
L_8e3056:
	bl.d L_8e727c
L_8e305a:
	mov_s r3,r15
L_8e305c:
	breq r0,0x1,L_8e306a
	.global L_8e3060
L_8e3060:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8e3062:
	cmp r14,-0x1
L_8e3066:
	bne_s L_8e3044
L_8e3068:
	b_s L_8e3072
	.global L_8e306a
L_8e306a:
	mov_s r0,r16
L_8e306c:
	bl.d L_8de4ec
L_8e3070:
	ld_s r1,[sp,0x0]
	.global L_8e3072
L_8e3072:
	ld_s r1,[sp,0x0]
L_8e3074:
	mov_s r0,r13
L_8e3076:
	breq_s r1,0,L_8e3084
L_8e3078:
	bl L_8c1fc4
L_8e307c:
	bl.d L_8d5244
L_8e3080:
	ld_s r0,[sp,0x0]
L_8e3082:
	b_s L_8e30a8
	.global L_8e3084
L_8e3084:
	mov_s r1,r13
L_8e3086:
	mov_s r2,r17
L_8e3088:
	bl.d L_8e727c
L_8e308c:
	mov_s r3,r15
L_8e308e:
	brne_s r0,0,L_8e30a8
L_8e3090:
	mov_s r0,blink
L_8e3092:
	mov_s r2,0x100a584
L_8e3098:
	mov_s r1,0x12b9
L_8e309e:
	bl.d L_8c82c0
L_8e30a2:
	mov r3,0x197
L_8e30a6:
	b_s L_8e30be
	.global L_8e30a8
L_8e30a8:
	ld_s r0,[sp,0x0]
L_8e30aa:
	mov_s r2,0x0
L_8e30ac:
	st_s r2,[r0,0x20]
L_8e30ae:
	ld_s r1,[sp,0x0]
L_8e30b0:
	mov_s r0,0x1dfc0
L_8e30b6:
	ldb_s r1,[r1,0x9]
L_8e30b8:
	bl.d L_8c2ac8
L_8e30bc:
	mov_s r3,0x1
	.global L_8e30be
L_8e30be:
	b.d L_8c031c
L_8e30c2:
	add_s sp,sp,0x8
