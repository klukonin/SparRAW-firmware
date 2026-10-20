/* conn_mgr__apply_default_link_maintain_cfg @ 0x8c3160, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::apply_default_link_maintain_cfg(): Setting default link_maintain_cfg. is_pcp_ap=%d, is_fst=%d, cfg_type=%d
 * Зовут его: conn_mgr__system_state_evt_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit3, link_maintain_cfg__copy, memcpy_fw
 */
	.section .text.conn_mgr__apply_default_link_maintain_cfg,"ax",@progbits
	.global conn_mgr__apply_default_link_maintain_cfg
conn_mgr__apply_default_link_maintain_cfg:
	.global L_8c3160
L_8c3160:
	push_s blink
L_8c3162:
	bl L_8c02bc
L_8c3166:
	mov.f r13,r0
L_8c316a:
	sub_s sp,sp,0x24
L_8c316c:
	mov_s r16,r1
L_8c316e:
	beq_s L_8c317a
L_8c3170:
	mov.f r15,r16
L_8c3174:
	mov.ne r15,0x1
L_8c3178:
	b_s L_8c3184
	.global L_8c317a
L_8c317a:
	mov.f r0,r16
L_8c317e:
	mov.ne r0,0x1
L_8c3182:
	add_s r15,r0,0x2
	.global L_8c3184
L_8c3184:
	mov_s r1,sp
L_8c3186:
	bl.d L_8c9fcc
L_8c318a:
	mov_s r0,r15
L_8c318c:
	mov_s r2,0x100aa2c
L_8c3192:
	mov_s r0,0xb
L_8c3194:
	mov_s r1,0x2
L_8c3196:
	mov_s r3,r13
L_8c3198:
	mov r4,r16
L_8c319c:
	bl.d L_8ee034
L_8c31a0:
	mov_s r5,r15
L_8c31a2:
	mov_s r13,0x0
L_8c31a4:
	mov_s r14,0x8
	.global L_8c31a6
L_8c31a6:
	asl_s r0,r13,0x2
L_8c31a8:
	add3_s r0,r0,r0
L_8c31aa:
	add_s r0,r0,0x857060
L_8c31b0:
	add_s r0,r0,0x1c
L_8c31b2:
	mov_s r1,sp
L_8c31b4:
	bl.d L_8c0460
L_8c31b8:
	mov_s r2,0x24
L_8c31ba:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8c31bc:
	/* brhs.d r14,0x1,0x008c31a6 */
	.byte 0xeb,0x0e,0x75,0x90
L_8c31c0:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8c31c2:
	b.d L_8c0324
L_8c31c6:
	add_s sp,sp,0x24
