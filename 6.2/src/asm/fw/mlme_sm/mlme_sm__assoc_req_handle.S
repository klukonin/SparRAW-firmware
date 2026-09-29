/* mlme_sm__assoc_req_handle @ 0x8f0e14, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dbi_write shadow DS #%d FAILED
 * Зовут его: pcie_perst_handler_step
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log_emit1, fw_sysassert_fatal, pcie__dbi_transfer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__assoc_req_handle
mlme_sm__assoc_req_handle:
	.global L_8f0e14
L_8f0e14:
	push_s blink
L_8f0e16:
	bl L_8c01cc
L_8f0e1a:
	mov_s r15,r1
L_8f0e1c:
	mov_s r14,r3
L_8f0e1e:
	mov r17,r4
L_8f0e22:
	mov r16,r5
L_8f0e26:
	sub r1,r6,0x1
L_8f0e2a:
	extb r18,r0
L_8f0e2e:
	extb_s r15,r15
L_8f0e30:
	extb r19,r2
L_8f0e34:
	extb r20,r3
L_8f0e38:
	mov_s r0,0x1
L_8f0e3a:
	push_s r0
L_8f0e3c:
	mov_s r0,r4
L_8f0e3e:
	mov_s r2,r18
L_8f0e40:
	mov_s r3,r15
L_8f0e42:
	mov r4,r19
L_8f0e46:
	mov r5,r20
L_8f0e4a:
	mov r6,0x1
L_8f0e4e:
	bl.d L_8c828c
L_8f0e52:
	mov r7,r6
L_8f0e56:
	mov_s r13,0x0
L_8f0e58:
	brne_s r0,0,L_8f0e74
L_8f0e5a:
	mov_s r1,0x1001630
L_8f0e60:
	mov_s r0,r13
L_8f0e62:
	bl.d L_8dcc10
L_8f0e66:
	mov_s r2,r14
L_8f0e68:
	mov_s r0,blink
L_8f0e6a:
	mov_s r1,0x11a2
L_8f0e70:
	bl L_8c9b28
	.global L_8f0e74
L_8f0e74:
	st_s r13,[sp,0x0]
L_8f0e76:
	mov_s r0,r17
L_8f0e78:
	mov_s r1,r16
L_8f0e7a:
	mov_s r2,r18
L_8f0e7c:
	mov_s r3,r15
L_8f0e7e:
	mov r4,r19
L_8f0e82:
	mov r5,r20
L_8f0e86:
	mov r6,0x1
L_8f0e8a:
	bl.d L_8c828c
L_8f0e8e:
	mov r7,r6
L_8f0e92:
	brne_s r0,0,L_8f0eae
L_8f0e94:
	mov_s r1,0x1001630
L_8f0e9a:
	mov_s r0,0x0
L_8f0e9c:
	bl.d L_8dcc10
L_8f0ea0:
	mov_s r2,r14
L_8f0ea2:
	mov_s r0,blink
L_8f0ea4:
	mov_s r1,0x11a3
L_8f0eaa:
	bl L_8c9b28
	.global L_8f0eae
L_8f0eae:
	b.d L_8c0224
L_8f0eb2:
	add_s sp,sp,0x4
