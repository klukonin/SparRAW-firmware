/* l2mgr__set_app_ie @ 0x8fbb90, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI_SET_APPIE frame type: %d
 * Зовут его: wmi__set_app_ie_thunk
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_sysassert_fatal, memcpy_fw, mid__apply_app_ies, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__set_app_ie
l2mgr__set_app_ie:
	.global L_8fbb90
L_8fbb90:
	push_s blink
L_8fbb92:
	bl L_8c01dc
L_8fbb96:
	mov_s r14,r0
L_8fbb98:
	bl.d L_8cc3dc
L_8fbb9c:
	mov_s r0,r1
L_8fbb9e:
	mov_s r16,r0
L_8fbba0:
	ldw_s r0,[r14,0x2]
L_8fbba2:
	mov_s r13,0x0
L_8fbba4:
	breq_s r0,0,L_8fbbba
L_8fbba6:
	cmp r0,0x400
L_8fbbaa:
	bgt_s L_8fbbd8
	.global L_8fbbac
L_8fbbac:
	bl L_8c3414
L_8fbbb0:
	add_s r1,r14,0x4
L_8fbbb2:
	mov_s r13,r0
L_8fbbb4:
	bl.d L_8c0380
L_8fbbb8:
	ldw_s r2,[r14,0x2]
	.global L_8fbbba
L_8fbbba:
	mov_s r1,0x100def4
L_8fbbc0:
	mov_s r0,0x2b
L_8fbbc2:
	bl.d L_8dcc10
L_8fbbc6:
	ldb_s r2,[r14]
L_8fbbc8:
	mov_s r0,r16
L_8fbbca:
	ldb_s r1,[r14]
L_8fbbcc:
	ldw_s r2,[r14,0x2]
L_8fbbce:
	bl.d L_8e61c0
L_8fbbd2:
	mov_s r3,r13
L_8fbbd4:
	b L_8c0244
	.global L_8fbbd8
L_8fbbd8:
	mov_s r0,blink
L_8fbbda:
	mov_s r1,0x11e6
L_8fbbe0:
	bl L_8c9b28
L_8fbbe4:
	b_s L_8fbbac
L_8fbbe6:
	nop_s
