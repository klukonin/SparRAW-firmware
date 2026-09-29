/* maintain_sm__action_8f2f0c @ 0x8f2f0c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MAINTAIN_SM::OPEN BF Triggers
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, conn__get_cid_of_obj, field_rw_0x00__8db534, field_set_0x1c__8d9c3c, fw_log_emit0, maintain_sm__get_mid_idx, mid_list__by_mid_fw, process_expected_bf_results
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8f2f0c
maintain_sm__action_8f2f0c:
	.global L_8f2f0c
L_8f2f0c:
	push_s blink
L_8f2f0e:
	bl L_8c01e0
L_8f2f12:
	mov_s r13,r0
L_8f2f14:
	ld_s r0,[r0,0x1c]
L_8f2f16:
	brne r0,0x0,L_8f2f96
L_8f2f1a:
	bl.d L_8cc3d4
L_8f2f1e:
	ld_s r0,[r13,0x8]
L_8f2f20:
	bl.d L_8cc3dc
L_8f2f24:
	mov_s r15,0x1
L_8f2f26:
	add r0,r13,0x2c
L_8f2f2a:
	mov_s r1,0x0
L_8f2f2c:
	mov_s r2,r1
L_8f2f2e:
	mov_s r3,r1
L_8f2f30:
	bl.d L_8d9b6c
L_8f2f34:
	mov_s r4,r1
L_8f2f36:
	ld_s r0,[r13,0x8]
L_8f2f38:
	mov_s r1,0x7
L_8f2f3a:
	mov_s r2,0x0
L_8f2f3c:
	mov_s r3,0x0
L_8f2f3e:
	bl.d L_8d9b6c
L_8f2f42:
	mov r4,0x0
L_8f2f46:
	mov_s r0,r13
L_8f2f48:
	bl.d L_8e11f8
L_8f2f4c:
	ldb_s r1,[r13,0x19]
L_8f2f4e:
	mov_s r1,0x1014668
L_8f2f54:
	bl.d L_8dcba8
L_8f2f58:
	mov_s r0,0x20
L_8f2f5a:
	ld_s r0,[r13,0xc]
L_8f2f5c:
	mov_s r1,0x1
L_8f2f5e:
	cmp_s r0,0x0
L_8f2f60:
	mov_s r0,0x803c00
L_8f2f66:
	ld_s r0,[r0,0xc]
L_8f2f68:
	sub_s.ne r1,r1,r1
L_8f2f6a:
	cmp_s r0,0x0
L_8f2f6c:
	sub_s.ne r14,r14,r14
L_8f2f6e:
	mov.eq r14,r1
L_8f2f72:
	sub_s.ne r15,r15,r15
L_8f2f74:
	bl.d L_8cbeb8
L_8f2f78:
	ld_s r0,[r13,0x8]
L_8f2f7a:
	mov_s r1,r15
L_8f2f7c:
	extb_s r0,r0
L_8f2f7e:
	mov_s r2,r14
L_8f2f80:
	mov_s r3,r15
L_8f2f82:
	mov_s r4,r15
L_8f2f84:
	mov_s r5,r15
L_8f2f86:
	bl.d L_8db534
L_8f2f8a:
	mov_s r6,r15
L_8f2f8c:
	ld_s r0,[gp,-0xe8]
L_8f2f8e:
	st_s r0,[r13,0x14]
L_8f2f90:
	bl.d L_8d9c3c
L_8f2f94:
	mov_s r0,r13
	.global L_8f2f96
L_8f2f96:
	b L_8c024c
L_8f2f9a:
	nop_s
