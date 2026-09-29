/* calib_mngr__reset_scheme @ 0x8c4b34, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_mngr.cpp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, calib_cfg__get_scheme, calib_engine__post_event, calib_mngr__schedule_scheme_step, fw_sysassert_fatal
 * Глобалы (через gp): 0x80023b
 */
	.section .text.calib_mngr__reset_scheme,"ax",@progbits
	.global calib_mngr__reset_scheme
calib_mngr__reset_scheme:
L_8c4b34:
	push_s blink
L_8c4b36:
	bl L_8c02bc
L_8c4b3a:
	brhs.d r0,0x6,L_8c4b9e
L_8c4b3e:
	mov_s r16,r0
	.global L_8c4b40
L_8c4b40:
	mov_s r14,0x0
L_8c4b42:
	mov_s r13,0x842840
L_8c4b48:
	add2 r12,r13,r16
L_8c4b4c:
	st_s r14,[r12,0x8]
L_8c4b4e:
	ldb_s r0,[gp,0xcb]
L_8c4b50:
	bl.d L_8ca4a4
L_8c4b54:
	ld.as r1,[gp,-0x2]
L_8c4b58:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c4b5a:
	asl r1,r16,0x2
L_8c4b5e:
	add1_s r1,r1,r1
L_8c4b60:
	add_s r1,r1,r0
L_8c4b62:
	asl r2,r16,0x5
L_8c4b66:
	add1_s r2,r2,r2
L_8c4b68:
	add r0,r13,0x20
L_8c4b6c:
	add_s r0,r0,r2
L_8c4b6e:
	ldb_s r2,[r0]
L_8c4b70:
	cmp_s r2,0x0
L_8c4b72:
	mov_s r2,0x1
L_8c4b74:
	sub_s.ne r2,r2,r2
L_8c4b76:
	extb.f 0x0,r2
L_8c4b7a:
	beq_s L_8c4bb4
L_8c4b7c:
	ld_s r3,[r1]
L_8c4b7e:
	ldw r4,[r1, 0xa]
L_8c4b82:
	lsr_s r3,r3
L_8c4b84:
	extb_s r3,r3
L_8c4b86:
	mov r5,0x4aec
L_8c4b8e:
	ld_s r1,[r1,0x4]
L_8c4b90:
	mov_s r2,0x1
L_8c4b92:
	mov r6,r16
L_8c4b96:
	bl.d L_8e27a4
L_8c4b9a:
	mov_s r7,r14
L_8c4b9c:
	b_s L_8c4bbc
	.global L_8c4b9e
L_8c4b9e:
	mov_s r0,blink
L_8c4ba0:
	mov_s r2,0x10085d4
L_8c4ba6:
	mov_s r1,0x94
L_8c4ba8:
	bset_s r1,r1,0xc
L_8c4baa:
	bl.d L_8c82c0
L_8c4bae:
	mov r3,0x18b
L_8c4bb2:
	b_s L_8c4b40
	.global L_8c4bb4
L_8c4bb4:
	mov_s r0,r16
L_8c4bb6:
	bl.d L_8dfcd4
L_8c4bba:
	mov_s r2,r14
	.global L_8c4bbc
L_8c4bbc:
	b L_8c0324
