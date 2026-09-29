/* lmac_if__key_evt @ 0x8d8bf4, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if.cpp
 *   RESET_KEYS event handle Sta id %d
 *   *** SET_GLOBAL_KEY EVENT RECEIVED FROM UCODE ***
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__by_cid, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal, l2mgr__apply_key_to_prings, l2mgr__notify_key_ready, lmac_if__gtk_key_id
 */
	.section .text.lmac_if__key_evt,"ax",@progbits
	.global lmac_if__key_evt
lmac_if__key_evt:
	.global L_8d8bf4
L_8d8bf4:
	push_s blink
L_8d8bf6:
	bl L_8c02c4
L_8d8bfa:
	mov_s r14,r0
L_8d8bfc:
	ld_s r0,[r0,0x4]
L_8d8bfe:
	mov_s r13,0x0
L_8d8c00:
	breq r0,0x4,L_8d8c10
L_8d8c04:
	bl.d L_8c9e44
L_8d8c08:
	ld_s r0,[r14]
L_8d8c0a:
	mov.f r13,r0
L_8d8c0e:
	beq_s L_8d8c32
	.global L_8d8c10
L_8d8c10:
	ld_s r0,[r14,0x4]
L_8d8c12:
	breq_s r0,0,L_8d8c48
L_8d8c14:
	breq r0,0x1,L_8d8c50
L_8d8c18:
	breq r0,0x4,L_8d8c68
L_8d8c1c:
	mov_s r0,blink
L_8d8c1e:
	mov_s r2,0x1003e50
L_8d8c24:
	mov_s r1,0x4c
L_8d8c26:
	bset_s r1,r1,0xc
L_8d8c28:
	bl.d L_8c82c0
L_8d8c2c:
	mov r3,0x309
L_8d8c30:
	b_s L_8d8c7a
	.global L_8d8c32
L_8d8c32:
	mov_s r0,blink
L_8d8c34:
	mov_s r2,0x1003e50
L_8d8c3a:
	mov_s r1,0x4b
L_8d8c3c:
	bset_s r1,r1,0xc
L_8d8c3e:
	bl.d L_8c82c0
L_8d8c42:
	mov r3,0x2f7
L_8d8c46:
	b_s L_8d8c10
	.global L_8d8c48
L_8d8c48:
	bl.d L_8ed5d4
L_8d8c4c:
	mov_s r0,r13
L_8d8c4e:
	b_s L_8d8c7a
	.global L_8d8c50
L_8d8c50:
	mov_s r2,0x1004318
L_8d8c56:
	mov_s r0,0x0
L_8d8c58:
	mov_s r1,0x2
L_8d8c5a:
	bl.d L_8edfcc
L_8d8c5e:
	ld_s r3,[r14]
L_8d8c60:
	bl.d L_8f28b4
L_8d8c64:
	mov_s r0,r13
L_8d8c66:
	b_s L_8d8c7a
	.global L_8d8c68
L_8d8c68:
	mov_s r2,0x100433c
L_8d8c6e:
	mov_s r0,0x5
L_8d8c70:
	bl.d L_8edfb0
L_8d8c74:
	mov_s r1,0x2
L_8d8c76:
	bl L_8cad54
	.global L_8d8c7a
L_8d8c7a:
	b L_8c0334
L_8d8c7e:
	nop_s
