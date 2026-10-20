/* rf_utils_auto_fill_uc @ 0x92ed84, 580 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rf_utils_auto_fill(): wrong input params; p_fill_info = 0x%x
 *   rf_utils_auto_fill(): Failed to read AUTO_FILL_BUSY for rfc_mask=0x%x
 *   rf_utils_auto_fill(): busy timeout
 * Зовут его: rf_utils__auto_fill_with_byte
 * Зовёт сам: hwd_rfc_auto_fill_verify, hwd_rfc_read_rgf_uc, rf_utils__fill_step, rfca__select_rf_uc, uc_log__emit1, uc_log__emit_snapshot, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf_utils_auto_fill_uc
rf_utils_auto_fill_uc:
	.global L_92ed84
L_92ed84:
	st.a r13,[sp,-0x24]
L_92ed88:
	st blink,[sp, 0x4]
L_92ed8c:
	st_s r14,[sp,0x8]
L_92ed8e:
	st_s r15,[sp,0xc]
L_92ed90:
	st r16,[sp, 0x10]
L_92ed94:
	st r17,[sp, 0x14]
L_92ed98:
	st r18,[sp, 0x18]
L_92ed9c:
	st r19,[sp, 0x1c]
L_92eda0:
	st r20,[sp, 0x20]
L_92eda4:
	mov.f r20,r0
L_92eda8:
	sub sp,sp,0x100
L_92edac:
	beq.d L_92edbc
L_92edb0:
	mov r18,r1
L_92edb4:
	ldb r10,[r20, 0x1]
L_92edb8:
	brlt r10,0x2,L_92edd0
	.global L_92edbc
L_92edbc:
	mov_s r1,0x1000e6c
L_92edc2:
	mov_s r0,0x0
L_92edc4:
	bl.d L_92d1d0
L_92edc8:
	mov r2,r20
L_92edcc:
	b L_92ef4c
	.global L_92edd0
L_92edd0:
	asl r10,r10,0x8
L_92edd4:
	add3 r10,r10,0x53c
L_92edd8:
	lsr r10,r10,0x3
L_92eddc:
	ldb r11,[r20, 0x3]
L_92ede0:
	bic r14,r10,0x3
L_92ede4:
	ldb r7,[r20, 0x2]
L_92ede8:
	asl r11,r11,0x8
L_92edec:
	ldb r8,[r20, 0xc]
L_92edf0:
	or r7,r7,r11
L_92edf4:
	asl r8,r8,0x10
L_92edf8:
	ld r3,[r20, 0x4]
L_92edfc:
	or r7,r7,r8
L_92ee00:
	breq.d r3,0x0,L_92ee4c
L_92ee04:
	mov_s r15,0x0
L_92ee06:
	ld r11,[r3]
L_92ee0a:
	ld r10,[r3, 0x4]
L_92ee0e:
	ld r9,[r3, 0x8]
L_92ee12:
	ld r8,[r3, 0xc]
L_92ee16:
	st r11,[sp]
L_92ee1a:
	st r10,[sp, 0x4]
L_92ee1e:
	st r9,[sp, 0x8]
L_92ee22:
	st r8,[sp, 0xc]
L_92ee26:
	ld r11,[r3, 0x10]
L_92ee2a:
	ld r10,[r3, 0x14]
L_92ee2e:
	st r11,[sp, 0x10]
L_92ee32:
	st r10,[sp, 0x14]
L_92ee36:
	ldb r9,[r20, 0x1]
L_92ee3a:
	mov_s r15,0x6
L_92ee3c:
	asl r9,r9,0x8
L_92ee40:
	add3 r9,r9,0x524
L_92ee44:
	lsr r9,r9,0x3
L_92ee48:
	bic r14,r9,0x3
	.global L_92ee4c
L_92ee4c:
	add2 r6,sp,r15
L_92ee50:
	st r7,[r6]
L_92ee54:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_92ee56:
	extw_s r15,r15
L_92ee58:
	mov r5,0x1
L_92ee5c:
	add2 r4,sp,r15
L_92ee60:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_92ee62:
	extw_s r15,r15
L_92ee64:
	st r5,[r4]
L_92ee68:
	brlt.d r15,0x1,L_92ee90
L_92ee6c:
	ldb r17,[r20]
L_92ee70:
	mov_s r13,sp
L_92ee72:
	extw_s r15,r15
	.global L_92ee74
L_92ee74:
	ld.ab r2,[r13,0x4]
L_92ee78:
	mov_s r0,r17
L_92ee7a:
	mov_s r1,r14
L_92ee7c:
	bl.d L_929f34
L_92ee80:
	mov r3,0x0
L_92ee84:
	sub r15,r15,0x1
L_92ee88:
	brhs.d r15,0x1,L_92ee74
L_92ee8c:
	add r14,r14,0x4
	.global L_92ee90
L_92ee90:
	breq.d r17,0x0,L_92eeb0
L_92ee94:
	mov r19,0x0
L_92ee98:
	mov r1,r17
	.global L_92ee9c
L_92ee9c:
	sub r2,r1,0x1
L_92eea0:
	and.f r1,r1,r2
L_92eea4:
	add r19,r19,0x1
L_92eea8:
	bne.d L_92ee9c
L_92eeac:
	extw r19,r19
	.global L_92eeb0
L_92eeb0:
	brlt.d r19,0x1,L_92ef4c
L_92eeb4:
	mov_s r15,0x1
L_92eeb6:
	mov_s r14,0xdeadbeef
L_92eebc:
	sub r19,r19,0x1
L_92eec0:
	extw r19,r19
L_92eec4:
	add r19,r19,0x1
	.global L_92eec8
L_92eec8:
	cmp r15,0x1
L_92eecc:
	ble.d L_92eeec
L_92eed0:
	mov.le r16,r17
L_92eed4:
	sub_s r2,r15,0x1
L_92eed6:
	extw_s r2,r2
L_92eed8:
	mov lp_count,r2
L_92eedc:
	mov r16,r17
L_92eee0:
	lp L_92eeec
L_92eee4:
	sub r1,r16,0x1
L_92eee8:
	and r16,r16,r1
	.global L_92eeec
L_92eeec:
	sub r3,r16,0x1
L_92eef0:
	bic r16,r16,r3
L_92eef4:
	extb r16,r16
L_92eef8:
	mov r0,r16
L_92eefc:
	bl.d L_928b8c
L_92ef00:
	mov r1,0x0
L_92ef04:
	mov r13,0x0
	.global L_92ef08
L_92ef08:
	mov r0,0x0
L_92ef0c:
	bl.d L_92a1cc
L_92ef10:
	mov r1,0x4f0
L_92ef14:
	breq r0,r14,L_92ef54
L_92ef18:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92ef1a:
	extw_s r13,r13
L_92ef1c:
	brge r13,0x2,L_92ef24
L_92ef20:
	bbit1 r0,0x0,L_92ef08
	.global L_92ef24
L_92ef24:
	bbit1 r0,0x0,L_92efa4
L_92ef28:
	mov_s r0,r20
L_92ef2a:
	mov_s r1,r16
L_92ef2c:
	bl.d L_93e7c4
L_92ef30:
	mov r2,r18
L_92ef34:
	cmp r18,0x0
L_92ef38:
	cmp.eq r0,0x0
L_92ef3c:
	beq_s L_92ef68
L_92ef3e:
	sub r19,r19,0x1
L_92ef42:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_92ef44:
	brhs.d r19,0x1,L_92eec8
L_92ef48:
	extw r15,r15
	.global L_92ef4c
L_92ef4c:
	b.d L_92ef6c
L_92ef50:
	mov r0,0x1
	.global L_92ef54
L_92ef54:
	mov_s r1,0x1000eac
L_92ef5a:
	mov_s r0,0x0
L_92ef5c:
	bl.d L_92d1d0
L_92ef60:
	mov r2,r16
L_92ef64:
	brne r18,0x0,L_92ef94
	.global L_92ef68
L_92ef68:
	mov r0,0x0
	.global L_92ef6c
L_92ef6c:
	add sp,sp,0x100
L_92ef70:
	ld blink,[sp, 0x4]
L_92ef74:
	ld_s r14,[sp,0x8]
L_92ef76:
	ld_s r15,[sp,0xc]
L_92ef78:
	ld r16,[sp, 0x10]
L_92ef7c:
	ld r17,[sp, 0x14]
L_92ef80:
	ld r18,[sp, 0x18]
L_92ef84:
	ld r19,[sp, 0x1c]
L_92ef88:
	ld r20,[sp, 0x20]
L_92ef8c:
	j.d [blink]
L_92ef90:
	ld.ab r13,[sp,0x24]
	.global L_92ef94
L_92ef94:
	mov r1,0x1565
L_92ef9c:
	b.d L_92efc0
L_92efa0:
	mov r0,blink
	.global L_92efa4
L_92efa4:
	mov r1,0x1000ef4
L_92efac:
	bl.d L_92d13c
L_92efb0:
	mov r0,0x0
L_92efb4:
	breq r18,0x0,L_92ef68
L_92efb8:
	mov_s r0,blink
L_92efba:
	mov_s r1,0x1566
	.global L_92efc0
L_92efc0:
	bl L_926618
L_92efc4:
	b_s L_92ef68
L_92efc6:
	nop_s
