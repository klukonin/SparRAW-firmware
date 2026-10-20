/* linkup__check_pcp_assoc_ready @ 0x8c3e40, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LINKUP Failure PCP Assoc ready = 0!!!
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__inject_event, basic_sm__store_pending_event, conn__store_linkup_field, fw_log__emit0, lm_if__on_linkup_ready, tail_lmac_if_send_cmd_0x04, u_schd__cancel
 */
	.section .text.linkup__check_pcp_assoc_ready,"ax",@progbits
	.global linkup__check_pcp_assoc_ready
linkup__check_pcp_assoc_ready:
	.byte 0x0f
	.byte 0xfe
	.global fwlog_LINKUP_Failure_PCP_Assoc_ready_0
fwlog_LINKUP_Failure_PCP_Assoc_ready_0:
L_8c3e42:
	nop_s
L_8c3e44:
	push_s blink
L_8c3e46:
	bl L_8c02c0
L_8c3e4a:
	mov_s r13,r0
L_8c3e4c:
	ld_s r0,[r0,0x74]
L_8c3e4e:
	mov_s r15,r1
L_8c3e50:
	mov_s r14,r2
L_8c3e52:
	breq_s r0,0,L_8c3e5c
L_8c3e54:
	bl L_8c7794
L_8c3e58:
	mov_s r0,0x0
L_8c3e5a:
	st_s r0,[r13,0x74]
	.global L_8c3e5c
L_8c3e5c:
	bl.d L_8d8498
L_8c3e60:
	mov_s r0,0x2
L_8c3e62:
	ld_s r0,[r13,0x2c]
L_8c3e64:
	ld_s r1,[r0,0x18]
L_8c3e66:
	add_s r0,r0,0x64
L_8c3e68:
	cmp_s r1,0x1
L_8c3e6a:
	mov_s r1,0x2
L_8c3e6c:
	mov.ne r1,0x1
L_8c3e70:
	bl L_8e55cc
L_8c3e74:
	ld_s r0,[r13,0x2c]
L_8c3e76:
	ld_s r1,[r0,0x20]
L_8c3e78:
	breq_s r1,0,L_8c3e8c
L_8c3e7a:
	mov_s r0,r13
L_8c3e7c:
	mov_s r1,0x2
L_8c3e7e:
	mov_s r2,0x0
L_8c3e80:
	mov_s r3,0x0
L_8c3e82:
	bl.d L_8d6a1c
L_8c3e86:
	mov r4,0x0
L_8c3e8a:
	b_s L_8c3ec8
	.global L_8c3e8c
L_8c3e8c:
	brne_s r15,0,L_8c3ea4
L_8c3e8e:
	breq_s r14,0,L_8c3eba
L_8c3e90:
	ld_s r1,[r14,0xc]
L_8c3e92:
	ld r1,[r1, 0xc0]
L_8c3e96:
	ldb_s r1,[r1,0x5]
L_8c3e98:
	btst_s r1,0x3
L_8c3e9a:
	bic.eq.f r1,r1,0xffffffcf
L_8c3ea2:
	beq_s L_8c3eac
	.global L_8c3ea4
L_8c3ea4:
	bl.d L_8d7d1c
L_8c3ea8:
	add_s r0,r0,0x64
L_8c3eaa:
	b_s L_8c3ec8
	.global L_8c3eac
L_8c3eac:
	mov_s r2,0x100f704
L_8c3eb2:
	mov_s r0,0xb
L_8c3eb4:
	bl.d L_8edfb0
L_8c3eb8:
	mov_s r1,0x0
	.global L_8c3eba
L_8c3eba:
	mov_s r0,r13
L_8c3ebc:
	mov_s r1,0x2
L_8c3ebe:
	mov_s r2,0x1
L_8c3ec0:
	mov_s r3,0x0
L_8c3ec2:
	bl.d L_8e20c0
L_8c3ec6:
	mov_s r4,r3
	.global L_8c3ec8
L_8c3ec8:
	b L_8c032c
