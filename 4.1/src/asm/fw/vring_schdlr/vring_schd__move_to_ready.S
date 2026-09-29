/* vring_schd__move_to_ready @ 0x8c1e44, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 *   High Priority #%d V-ring -> moved to ready queue.
 * Зовут его: vring_schd__alloc_pring, vring_schd__resume_vring, vring_schd__vring_task
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, fw_sysassert_fatal, llist__insert, sm_pring__get_vring, tail_sm_pring__state_step, vring__reg_write_locked_28, vring__reg_write_locked_3c, vring_hw__set_ready_bit, vring_schd__bind_if_free, vring_schd__is_vring_ready
 */
	.section .text.vring_schd__move_to_ready,"ax",@progbits
	.global vring_schd__move_to_ready
vring_schd__move_to_ready:
	.global L_8c1e44
L_8c1e44:
	push_s blink
L_8c1e46:
	bl L_8c02b8
L_8c1e4a:
	mov_s r15,r0
L_8c1e4c:
	ldb_s r0,[r1,0xb]
L_8c1e4e:
	brhs.d r0,0x2,L_8c1e84
L_8c1e52:
	mov_s r13,r1
	.global L_8c1e54
L_8c1e54:
	mov_s r0,r15
L_8c1e56:
	bl.d L_8c4d20
L_8c1e5a:
	ldb_s r1,[r13,0x8]
L_8c1e5c:
	mov.f r14,r0
L_8c1e60:
	beq_s L_8c1f38
L_8c1e62:
	ld r17,[r14, 0x14]
L_8c1e66:
	brne r17,0x0,L_8c1e9c
L_8c1e6a:
	mov_s r0,0x804580
L_8c1e70:
	bl.d L_8c588c
L_8c1e74:
	ldb_s r1,[r13,0xa]
L_8c1e76:
	brne_s r0,0,L_8c1e9c
L_8c1e78:
	mov_s r0,r15
L_8c1e7a:
	mov_s r1,r13
L_8c1e7c:
	bl.d L_8c6300
L_8c1e80:
	mov_s r2,r14
L_8c1e82:
	b_s L_8c1f54
	.global L_8c1e84
L_8c1e84:
	mov_s r0,blink
L_8c1e86:
	mov_s r2,0x100a584
L_8c1e8c:
	mov_s r1,0x1475
L_8c1e92:
	bl.d L_8c82c0
L_8c1e96:
	mov r3,0x2ab
L_8c1e9a:
	b_s L_8c1e54
	.global L_8c1e9c
L_8c1e9c:
	ldb_s r0,[r13,0x8]
L_8c1e9e:
	breq r0,0x1,L_8c1f08
	.global L_8c1ea2
L_8c1ea2:
	ldb_s r1,[r13,0xb]
L_8c1ea4:
	mov r16,0x2
L_8c1ea8:
	brne r1,0x1,L_8c1ece
L_8c1eac:
	mov_s r2,0x100a60c
L_8c1eb2:
	mov_s r0,0x7
L_8c1eb4:
	mov_s r1,r16
L_8c1eb6:
	bl.d L_8edfcc
L_8c1eba:
	ldb_s r3,[r13,0x9]
L_8c1ebc:
	breq r17,0x0,L_8c1f20
	.global L_8c1ec0
L_8c1ec0:
	mov_s r1,0x4
L_8c1ec2:
	st r1,[r17, 0x24]
L_8c1ec6:
	mov_s r0,r15
L_8c1ec8:
	bl.d L_8e2fec
L_8c1ecc:
	mov_s r1,r14
	.global L_8c1ece
L_8c1ece:
	ldb_s r1,[r13,0xb]
L_8c1ed0:
	add r0,r15,0xc
L_8c1ed4:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8c1ed6:
	add1_s r1,r1,r1
L_8c1ed8:
	add_s r0,r0,r1
L_8c1eda:
	bl.d L_8c1fc4
L_8c1ede:
	mov_s r1,r13
L_8c1ee0:
	st r16,[r13, 0x24]
L_8c1ee4:
	ldw_s r1,[r14]
L_8c1ee6:
	mov_s r0,0x0
L_8c1ee8:
	bset r0,r0,r1
L_8c1eec:
	bl.d L_8cd6ac
L_8c1ef0:
	mov_s r1,0x0
L_8c1ef2:
	bl.d L_8cd70c
L_8c1ef6:
	ldw_s r0,[r14]
L_8c1ef8:
	ldw_s r1,[r14]
L_8c1efa:
	mov_s r0,0x0
L_8c1efc:
	bset r0,r0,r1
L_8c1f00:
	bl.d L_8cd6dc
L_8c1f04:
	mov_s r1,0x1
L_8c1f06:
	b_s L_8c1f54
	.global L_8c1f08
L_8c1f08:
	mov_s r0,blink
L_8c1f0a:
	mov_s r2,0x100a584
L_8c1f10:
	mov_s r1,0x140e
L_8c1f16:
	bl.d L_8c82c0
L_8c1f1a:
	mov r3,0x2ba
L_8c1f1e:
	b_s L_8c1ea2
	.global L_8c1f20
L_8c1f20:
	mov_s r0,blink
L_8c1f22:
	mov_s r2,0x100a584
L_8c1f28:
	mov_s r1,0x147c
L_8c1f2e:
	bl.d L_8c82c0
L_8c1f32:
	mov r3,0x2c1
L_8c1f36:
	b_s L_8c1ec0
	.global L_8c1f38
L_8c1f38:
	ldb_s r0,[r13,0x8]
L_8c1f3a:
	breq r0,0x1,L_8c1f58
	.global L_8c1f3e
L_8c1f3e:
	ldb_s r1,[r13,0xb]
L_8c1f40:
	add r0,r15,0xc
L_8c1f44:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8c1f46:
	add1_s r1,r1,r1
L_8c1f48:
	add_s r0,r0,r1
L_8c1f4a:
	bl.d L_8c1fc4
L_8c1f4e:
	mov_s r1,r13
L_8c1f50:
	mov_s r0,0x2
L_8c1f52:
	st_s r0,[r13,0x24]
	.global L_8c1f54
L_8c1f54:
	b L_8c031c
	.global L_8c1f58
L_8c1f58:
	mov_s r0,blink
L_8c1f5a:
	mov_s r2,0x100a584
L_8c1f60:
	mov_s r1,0x140d
L_8c1f66:
	bl.d L_8c82c0
L_8c1f6a:
	mov r3,0x2d1
L_8c1f6e:
	b_s L_8c1f3e
