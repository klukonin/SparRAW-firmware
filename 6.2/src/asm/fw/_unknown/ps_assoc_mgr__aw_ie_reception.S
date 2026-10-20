/* ps_assoc_mgr__aw_ie_reception @ 0x8c3e9c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ps_assoc_mgr::aw_ie_reception Previous AW Duration: %d. New AW Duration %d
 * Зовут его: ps_assoc_mgr__shallow_sleep_enter
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, mac__tsf_lo_after_n_bi, memcpy_fw, mid__get_aw_len, mid__set_awake_window, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_assoc_mgr__aw_ie_reception
ps_assoc_mgr__aw_ie_reception:
	.global L_8c3e9c
L_8c3e9c:
	push_s blink
L_8c3e9e:
	bl L_8c01e0
L_8c3ea2:
	sub_s sp,sp,0x4
L_8c3ea4:
	mov_s r14,r1
L_8c3ea6:
	mov_s r13,0x0
L_8c3ea8:
	bl.d L_8cc3dc
L_8c3eac:
	mov_s r0,r13
L_8c3eae:
	add3 r15,r0,0x9
L_8c3eb2:
	breq_s r14,0,L_8c3ec2
L_8c3eb4:
	add r0,sp,0x2
L_8c3eb8:
	mov_s r1,r14
L_8c3eba:
	bl.d L_8c0380
L_8c3ebe:
	mov_s r2,0x2
L_8c3ec0:
	b_s L_8c3ec6
	.global L_8c3ec2
L_8c3ec2:
	stw r13,[sp, 0x2]
	.global L_8c3ec6
L_8c3ec6:
	bl.d L_8cb914
L_8c3eca:
	mov_s r0,r15
L_8c3ecc:
	ldw r3,[sp, 0x2]
L_8c3ed0:
	mov_s r13,r0
L_8c3ed2:
	breq r0,r3,L_8c3f00
L_8c3ed6:
	mov_s r1,0x1002378
L_8c3edc:
	mov_s r0,0x2b
L_8c3ede:
	bl.d L_8dcc80
L_8c3ee2:
	mov_s r2,r13
L_8c3ee4:
	ldw r0,[sp, 0x2]
L_8c3ee8:
	cmp_s r13,r0
L_8c3eea:
	mov_s r0,0x0
L_8c3eec:
	mov.ls r0,0x4
L_8c3ef0:
	bl L_8e9874
L_8c3ef4:
	mov_s r2,r0
L_8c3ef6:
	mov_s r0,r15
L_8c3ef8:
	bl.d L_8e62f0
L_8c3efc:
	ldw r1,[sp, 0x2]
	.global L_8c3f00
L_8c3f00:
	b.d L_8c024c
L_8c3f04:
	add_s sp,sp,0x4
L_8c3f06:
	nop_s
