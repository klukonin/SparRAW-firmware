/* l2mgr__publish_assoc_done @ 0x8e9bc0, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [L2MGR] Ignore association_done_evt CID: %d (mid %d)>>> not connected
 *   [L2MGR] publish association_done_evt CID: %d (mid %d)
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r17_to_r13_ret, __st_r17_to_r13, dashboard__add_connection, fw_log__emit2, l2mgr__program_assoc_vring, l2mgr__send_host_event, l2mgr__send_pbss_joined_evt, mid__type_of, set_reg_880a44, tail_lmac_if_send_cmd_0x1b
 */
	.section .text.l2mgr__publish_assoc_done,"ax",@progbits
	.global l2mgr__publish_assoc_done
l2mgr__publish_assoc_done:
L_8e9bc0:
	add_s sp,sp,0xc
	.global fwlog_L2MGR_Ignore_association_done_evt_CID_d_
fwlog_L2MGR_Ignore_association_done_evt_CID_d_:
L_8e9bc2:
	nop_s
L_8e9bc4:
	push_s blink
L_8e9bc6:
	bl L_8c02b8
L_8e9bca:
	mov_s r14,r0
L_8e9bcc:
	ld_s r13,[r0,0xc]
L_8e9bce:
	ld r0,[r0, 0xe0]
L_8e9bd2:
	ldb_s r3,[r14,0x8]
L_8e9bd4:
	ldb r4,[r13, 0x10]
L_8e9bd8:
	brne_s r0,0,L_8e9bee
L_8e9bda:
	ld_s r0,[r14,0x1c]
L_8e9bdc:
	brne_s r0,0,L_8e9bee
L_8e9bde:
	mov_s r2,0x100c5a4
L_8e9be4:
	mov_s r0,0xb
L_8e9be6:
	bl.d L_8edff8
L_8e9bea:
	mov_s r1,0x2
L_8e9bec:
	b_s L_8e9c50
	.global L_8e9bee
L_8e9bee:
	mov_s r2,0x100c5ec
L_8e9bf4:
	mov_s r0,0xb
L_8e9bf6:
	bl.d L_8edff8
L_8e9bfa:
	mov_s r1,0x2
L_8e9bfc:
	ldb r17,[r14, 0x8]
L_8e9c00:
	add r15,r14,0x10
L_8e9c04:
	ld_s r0,[r14,0xc]
L_8e9c06:
	bl.d L_8cabe4
L_8e9c0a:
	add r16,r0,0xa
L_8e9c0e:
	mov_s r4,r0
L_8e9c10:
	mov_s r0,0x0
L_8e9c12:
	mov_s r1,r17
L_8e9c14:
	mov_s r2,r15
L_8e9c16:
	mov_s r3,r16
L_8e9c18:
	bl.d L_8d7f40
L_8e9c1c:
	mov r5,0x1
L_8e9c20:
	ld_s r0,[r14,0x1c]
L_8e9c22:
	breq_s r0,0,L_8e9c2c
L_8e9c24:
	bl.d L_8eea68
L_8e9c28:
	mov_s r0,r14
L_8e9c2a:
	b_s L_8e9c34
	.global L_8e9c2c
L_8e9c2c:
	ldb_s r0,[r13,0x10]
L_8e9c2e:
	bl.d L_8f0380
L_8e9c32:
	ldb_s r1,[r14,0x8]
	.global L_8e9c34
L_8e9c34:
	mov_s r0,0x5
L_8e9c36:
	bl.d L_8e3a08
L_8e9c3a:
	ldb_s r1,[r14,0x8]
L_8e9c3c:
	mov_s r0,0x0
L_8e9c3e:
	bl.d L_8c63a4
L_8e9c42:
	ldb_s r1,[r13,0x10]
L_8e9c44:
	bl.d L_8e35cc
L_8e9c48:
	mov_s r0,0x6
L_8e9c4a:
	bl.d L_8e5868
L_8e9c4e:
	mov_s r0,r14
	.global L_8e9c50
L_8e9c50:
	b L_8c031c
