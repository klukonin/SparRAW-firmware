/* vring__wait_macq_delete @ 0x8c3a00, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   VRING %d is waiting for TX MACQ delete notification. q_is_empty %d
 *   Configuring QUEUE back to ImmAck. m_ssn:%0x
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit1, fw_log__emit2, lmac_if_send_cmd_0x08, mid__conn_state_ne_1, sw_vring__setup_macq, tx_macq__is_empty, vring__get_pring_id, vring__write_macq_desc, vring_by_index, vring_schd__resume_vring
 */
	.section .text.vring__wait_macq_delete,"ax",@progbits
	.global vring__wait_macq_delete
vring__wait_macq_delete:
L_8c3a00:
	extw_s r2,r2
	.global fwlog_VRING_d_is_waiting_for_TX_MACQ_delete_no
fwlog_VRING_d_is_waiting_for_TX_MACQ_delete_no:
L_8c3a02:
	nop_s
L_8c3a04:
	push_s blink
L_8c3a06:
	bl L_8c02b4
L_8c3a0a:
	mov_s r13,r0
L_8c3a0c:
	mov_s r0,0x0
L_8c3a0e:
	mov_s r16,r0
L_8c3a10:
	add3 r14,r13,0x10
L_8c3a14:
	st_s r0,[r14,0x40]
L_8c3a16:
	ld_s r0,[r14,0x54]
L_8c3a18:
	sub_s sp,sp,0x30
L_8c3a1a:
	ld_s r1,[r0,0x1c]
L_8c3a1c:
	jl_s.d [r1]
L_8c3a1e:
	mov_s r0,r13
L_8c3a20:
	bl.d L_8cacc0
L_8c3a24:
	ldb_s r0,[r13,0x7]
L_8c3a26:
	mov_s r15,r0
L_8c3a28:
	ld_s r0,[r14,0x44]
L_8c3a2a:
	mov_s r14,0x2
L_8c3a2c:
	breq_s r0,0,L_8c3a7c
L_8c3a2e:
	mov_s r0,r15
L_8c3a30:
	bl.d L_8d7084
L_8c3a34:
	mov_s r1,r16
L_8c3a36:
	cmp_s r0,0x0
L_8c3a38:
	mov r16,0x1
L_8c3a3c:
	sub.ne r16,r16,r16
L_8c3a40:
	bl.d L_8c9d94
L_8c3a44:
	mov_s r0,r13
L_8c3a46:
	extb_s r2,r0
L_8c3a48:
	mov_s r0,0x3
L_8c3a4a:
	mov_s r1,0x1
L_8c3a4c:
	ldb_s r3,[r13,0x5]
L_8c3a4e:
	mov r4,0x0
L_8c3a52:
	mov r5,0x0
L_8c3a56:
	bl.d L_8d8864
L_8c3a5a:
	mov r6,r16
L_8c3a5e:
	bl.d L_8cacc0
L_8c3a62:
	ldb_s r0,[r13,0x5]
L_8c3a64:
	mov_s r2,0x100f084
L_8c3a6a:
	stb_s r14,[r0,0x2]
L_8c3a6c:
	ldb_s r3,[r13,0x7]
L_8c3a6e:
	mov_s r0,0xb
L_8c3a70:
	mov_s r1,r14
L_8c3a72:
	bl.d L_8edff8
L_8c3a76:
	mov r4,r16
L_8c3a7a:
	b_s L_8c3acc
	.global L_8c3a7c
L_8c3a7c:
	mov_s r0,sp
L_8c3a7e:
	ldb_s r1,[r15]
L_8c3a80:
	mov_s r2,r14
L_8c3a82:
	mov_s r3,0x3
L_8c3a84:
	bl.d L_8c4768
L_8c3a88:
	mov r4,0x1
L_8c3a8c:
	ld_s r3,[sp,0x4]
L_8c3a8e:
	add3 r17,r13,0x18
L_8c3a92:
	bmsk_s r3,r3,0xb
L_8c3a94:
	stw r3,[r17, 0x8]
L_8c3a98:
	mov_s r2,0x100f0c8
L_8c3a9e:
	mov_s r0,0xb
L_8c3aa0:
	bl.d L_8edfcc
L_8c3aa4:
	mov_s r1,r14
L_8c3aa6:
	ld_s r0,[r13]
L_8c3aa8:
	bl.d L_8ed820
L_8c3aac:
	ldb r18,[r0, 0x8]
L_8c3ab0:
	mov_s r6,r0
L_8c3ab2:
	ldw r5,[r17, 0x8]
L_8c3ab6:
	mov_s r0,r15
L_8c3ab8:
	mov_s r1,0x5
L_8c3aba:
	ldb_s r2,[r13,0x4]
L_8c3abc:
	mov_s r3,r16
L_8c3abe:
	bl.d L_8e5304
L_8c3ac2:
	mov r4,r18
L_8c3ac6:
	bl.d L_8de858
L_8c3aca:
	ldb_s r0,[r13,0x7]
	.global L_8c3acc
L_8c3acc:
	b.d L_8c0314
