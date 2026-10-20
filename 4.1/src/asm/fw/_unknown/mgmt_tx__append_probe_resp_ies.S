/* mgmt_tx__append_probe_resp_ies @ 0x8ecaec, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MGMT TX Probe resp ssid IE length %d total %d
 *   MGMT TX Probe resp RSN IE length %d total %d
 *   MGMT TX Probe resp dband cap length %d total %d
 *   MGMT TX Probe resp dband oper length %d total %d
 *   MGMT TX Probe resp dband ANT length %d total %d
 * Зовут его: mgmt_tx__build_probe_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2, ie__push_dmg_capabilities, ie__push_edca, ie__push_eid151_len10, ie__push_eid190_len4, ie__push_qos_capability, ie__push_raw, ie__push_ssid, mid__copy_ssid
 */
	.section .text.mgmt_tx__append_probe_resp_ies,"ax",@progbits
	.global mgmt_tx__append_probe_resp_ies
mgmt_tx__append_probe_resp_ies:
	.global L_8ecaec
L_8ecaec:
	push_s blink
L_8ecaee:
	bl L_8c02bc
L_8ecaf2:
	sub_s sp,sp,0x20
L_8ecaf4:
	mov_s r15,r0
L_8ecaf6:
	mov_s r13,r1
L_8ecaf8:
	mov_s r14,sp
L_8ecafa:
	mov_s r0,r1
L_8ecafc:
	bl.d L_8ca928
L_8ecb00:
	mov_s r1,r14
L_8ecb02:
	extb_s r2,r0
L_8ecb04:
	mov_s r0,r15
L_8ecb06:
	bl.d L_8ef8dc
L_8ecb0a:
	mov_s r1,r14
L_8ecb0c:
	mov_s r16,r0
L_8ecb0e:
	add_s r14,r0,r15
L_8ecb10:
	mov_s r2,0x100bcb8
L_8ecb16:
	mov_s r0,0xd
L_8ecb18:
	mov_s r1,0x2
L_8ecb1a:
	mov_s r3,r16
L_8ecb1c:
	bl.d L_8edff8
L_8ecb20:
	mov r4,r16
L_8ecb24:
	add3 r1,r13,0x30
L_8ecb28:
	bl.d L_8ef898
L_8ecb2c:
	mov_s r0,r14
L_8ecb2e:
	mov_s r3,r0
L_8ecb30:
	add_s r14,r14,r0
L_8ecb32:
	add r16,r16,r0
L_8ecb36:
	mov_s r2,0x100bce8
L_8ecb3c:
	mov_s r0,0xd
L_8ecb3e:
	mov_s r1,0x2
L_8ecb40:
	bl.d L_8edff8
L_8ecb44:
	mov r4,r16
L_8ecb48:
	add1 r1,r13,0x2f
L_8ecb4c:
	mov_s r0,r14
L_8ecb4e:
	bl.d L_8ef87c
L_8ecb52:
	mov_s r2,0x0
L_8ecb54:
	mov_s r3,r0
L_8ecb56:
	add r16,r16,r0
L_8ecb5a:
	add_s r14,r14,r0
L_8ecb5c:
	mov_s r2,0x100bd18
L_8ecb62:
	mov_s r0,0xd
L_8ecb64:
	mov_s r1,0x2
L_8ecb66:
	bl.d L_8edff8
L_8ecb6a:
	mov r4,r16
L_8ecb6e:
	add3 r1,r13,0x1f
L_8ecb72:
	bl.d L_8ef864
L_8ecb76:
	mov_s r0,r14
L_8ecb78:
	mov_s r3,r0
L_8ecb7a:
	add r16,r16,r0
L_8ecb7e:
	add_s r14,r14,r0
L_8ecb80:
	mov_s r2,0x100bd48
L_8ecb86:
	mov_s r0,0xd
L_8ecb88:
	mov_s r1,0x2
L_8ecb8a:
	bl.d L_8edff8
L_8ecb8e:
	mov r4,r16
L_8ecb92:
	mov_s r1,r13
L_8ecb94:
	add r1,r1,0x103
L_8ecb98:
	bl.d L_8ef84c
L_8ecb9c:
	mov_s r0,r14
L_8ecb9e:
	mov_s r3,r0
L_8ecba0:
	add r16,r16,r0
L_8ecba4:
	add_s r14,r14,r0
L_8ecba6:
	mov_s r2,0x100bd7c
L_8ecbac:
	mov_s r0,0xd
L_8ecbae:
	mov_s r1,0x2
L_8ecbb0:
	bl.d L_8edff8
L_8ecbb4:
	mov r4,r16
L_8ecbb8:
	mov_s r0,r14
L_8ecbba:
	bl.d L_8ef7b8
L_8ecbbe:
	mov_s r1,r13
L_8ecbc0:
	add r13,r0,r16
L_8ecbc4:
	bl.d L_8ef804
L_8ecbc8:
	add_s r0,r0,r14
L_8ecbca:
	add_s r0,r0,r13
L_8ecbcc:
	extw_s r0,r0
L_8ecbce:
	b.d L_8c0324
L_8ecbd2:
	add_s sp,sp,0x20
