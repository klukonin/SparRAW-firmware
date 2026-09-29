/* ftm__session_step @ 0x8e4bc8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: state_sm_8034c0__step_b, tof__find_session_by_addr, tof_mgr, tof_mgr__ftm_req_done
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm__session_step
ftm__session_step:
	.global L_8e4bc8
L_8e4bc8:
	push_s blink
L_8e4bca:
	bl L_8c01e4
L_8e4bce:
	sub_s sp,sp,0x4
L_8e4bd0:
	mov_s r14,r2
L_8e4bd2:
	mov_s r13,sp
L_8e4bd4:
	bl.d L_8e5df4
L_8e4bd8:
	mov_s r0,r13
L_8e4bda:
	b_s L_8e4bea
	.global L_8e4bdc
L_8e4bdc:
	bl.d L_8df438
L_8e4be0:
	mov_s r0,r13
L_8e4be2:
	ldb_s r2,[r14]
L_8e4be4:
	ldb_s r1,[r0,0x10]
L_8e4be6:
	breq r2,r1,L_8e4bf6
	.global L_8e4bea
L_8e4bea:
	bl.d L_8cdcb8
L_8e4bee:
	mov_s r0,r13
L_8e4bf0:
	brne_s r0,0,L_8e4bdc
L_8e4bf2:
	mov_s r0,0x0
L_8e4bf4:
	b_s L_8e4c1e
	.global L_8e4bf6
L_8e4bf6:
	ldb_s r2,[r14,0x1]
L_8e4bf8:
	ldb_s r1,[r0,0x11]
L_8e4bfa:
	brne r2,r1,L_8e4bea
L_8e4bfe:
	ldb_s r2,[r14,0x2]
L_8e4c00:
	ldb_s r1,[r0,0x12]
L_8e4c02:
	brne r2,r1,L_8e4bea
L_8e4c06:
	ldb_s r2,[r14,0x3]
L_8e4c08:
	ldb_s r1,[r0,0x13]
L_8e4c0a:
	brne r2,r1,L_8e4bea
L_8e4c0e:
	ldb_s r2,[r14,0x4]
L_8e4c10:
	ldb_s r1,[r0,0x14]
L_8e4c12:
	brne r2,r1,L_8e4bea
L_8e4c16:
	ldb_s r2,[r14,0x5]
L_8e4c18:
	ldb_s r1,[r0,0x15]
L_8e4c1a:
	brne r2,r1,L_8e4bea
	.global L_8e4c1e
L_8e4c1e:
	b.d L_8c0254
L_8e4c22:
	add_s sp,sp,0x4
