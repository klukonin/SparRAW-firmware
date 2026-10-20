/* brp__mode_step @ 0x922df8, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_substate__brp_mode_by_slot
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_substate__set, brp__count_active_sectors, brp__flow_main, brp__reset_db, mac_mode_brp_step, mac_mode_step_b, sxd_hal__mac_select_indexed
 */
	.section .text.brp__mode_step,"ax",@progbits
	.global brp__mode_step
brp__mode_step:
	.global L_922df8
L_922df8:
	push_s blink
L_922dfa:
	bl L_920210
L_922dfe:
	mov_s r15,r0
L_922e00:
	bl.d L_92822c
L_922e04:
	extb_s r0,r0
L_922e06:
	mov_s r0,r15
L_922e08:
	bl.d L_930dc4
L_922e0c:
	mov_s r1,0x31
L_922e0e:
	mov_s r13,0x800734
L_922e14:
	ld_s r0,[r13,0x10]
L_922e16:
	bbit0 r0,0x2,L_922e26
L_922e1a:
	bl L_922ec8
L_922e1e:
	breq_s r0,0,L_922e70
L_922e20:
	ld_s r0,[r13,0x10]
L_922e22:
	bclr_s r0,r0,0x2
L_922e24:
	st_s r0,[r13,0x10]
	.global L_922e26
L_922e26:
	bl L_922d08
L_922e2a:
	breq_s r0,0,L_922e70
L_922e2c:
	mov_s r0,r15
L_922e2e:
	bl.d L_930dc4
L_922e32:
	mov_s r1,0x30
L_922e34:
	mov_s r14,0x0
L_922e36:
	mov_s r13,0x20
	.global L_922e38
L_922e38:
	mov_s r0,0x801090
L_922e3e:
	sub r0,r0,0x40
L_922e42:
	add_s r0,r0,r14
L_922e44:
	ldb r0,[r0, 0x5c]
L_922e48:
	bl.d L_92b3e4
L_922e4c:
	extb_s r1,r14
L_922e4e:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_922e50:
	/* brhs.d r13,0x1,0x00922e38 */
	.byte 0xe9,0x0d,0x75,0x90
L_922e54:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_922e56:
	bl.d L_924938
L_922e5a:
	mov_s r0,r15
L_922e5c:
	bl.d L_9250a8
L_922e60:
	mov_s r0,0x0
L_922e62:
	mov_s r0,0x52
L_922e64:
	asl_s r0,r0,0x18
L_922e66:
	mov_s r32,r0
L_922e68:
	st.ab r0,[r25,0x4]
L_922e6c:
	bclr r25,r25,0xa
	.global L_922e70
L_922e70:
	b L_92027c
