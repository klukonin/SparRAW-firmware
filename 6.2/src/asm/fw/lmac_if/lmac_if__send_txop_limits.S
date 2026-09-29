/* lmac_if__send_txop_limits @ 0x8dbaa0, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, lmac_if__post_cmd, mem_pool__alloc_locked
 * Глобалы (через gp): 0x8003f0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_txop_limits
lmac_if__send_txop_limits:
	.global L_8dbaa0
L_8dbaa0:
	push_s blink
L_8dbaa2:
	bl L_8c01e4
L_8dbaa6:
	mov_s r0,0x804280
L_8dbaac:
	bl L_8c33d0
L_8dbab0:
	mov_s r13,r0
L_8dbab2:
	mov_s r0,0x803c00
L_8dbab8:
	ld_s r0,[r0,0xc]
L_8dbaba:
	breq_s r0,0,L_8dbac4
L_8dbabc:
	mov r0,0x500
L_8dbac0:
	st.as r0,[gp,0x9b]
	.global L_8dbac4
L_8dbac4:
	breq_s r13,0,L_8dbb00
L_8dbac6:
	mov_s r14,0x0
L_8dbac8:
	b_s L_8dbaf0
	.global L_8dbaca
L_8dbaca:
	ld_s r0,[gp,0x26c]
L_8dbacc:
	add1 r12,r13,r14
L_8dbad0:
	extw_s r1,r0
L_8dbad2:
	stw_s r0,[r12]
L_8dbad4:
	cmp_s r1,0x800
L_8dbada:
	mov.ge r0,blink
L_8dbade:
	mov.ge r1,0xd1
L_8dbae6:
	bl.ge.d L_8c9b28
L_8dbaea:
	bset.ge r1,r1,0xc
L_8dbaee:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8dbaf0
L_8dbaf0:
	brlt r14,0x4,L_8dbaca
L_8dbaf4:
	mov_s r0,r13
L_8dbaf6:
	mov_s r1,0x21
L_8dbaf8:
	mov_s r2,0x8
L_8dbafa:
	bl.d L_8e5204
L_8dbafe:
	mov_s r3,0x0
	.global L_8dbb00
L_8dbb00:
	b L_8c0254
