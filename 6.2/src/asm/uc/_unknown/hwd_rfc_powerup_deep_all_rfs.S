/* hwd_rfc_powerup_deep_all_rfs @ 0x92a0a0, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_powerup_deep_all_rfs - rfs: 0x%x
 *   hwd_rfc_powerup_deep_all_rfs - res: %d. timeout %d
 *   hwd_rfc_powerup_deep_all_rfs - FAILED TO READ FROM RF !!!
 * Зовут его: hw__power_sequence_rf
 * Зовёт сам: bit_iter__has_more_uc, field_set_0x00__934b8c, notify_aoa, rfc__read_core_result, rfc__restore_txrx_sets, rfca__select_rf_uc, uc_log__emit1, uc_log__emit2, uc_log__emit_snapshot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_powerup_deep_all_rfs
hwd_rfc_powerup_deep_all_rfs:
	.global L_92a0a0
L_92a0a0:
	st.a r13,[sp,-0x1c]
L_92a0a4:
	st blink,[sp, 0x4]
L_92a0a8:
	st_s r14,[sp,0x8]
L_92a0aa:
	st_s r15,[sp,0xc]
L_92a0ac:
	st r16,[sp, 0x10]
L_92a0b0:
	st r17,[sp, 0x14]
L_92a0b4:
	st r18,[sp, 0x18]
L_92a0b8:
	sub_s sp,sp,0xc
L_92a0ba:
	mov_s r3,0x0
L_92a0bc:
	st_s r3,[sp,0x4]
L_92a0be:
	mov r16,0xa
L_92a0c2:
	stb r16,[gp, -0xe2]
L_92a0c6:
	ldb r17,[0x8006b6]
L_92a0ce:
	mov_s r1,0x1002000
L_92a0d4:
	mov r0,0x29
L_92a0d8:
	bl.d L_92d1d0
L_92a0dc:
	mov r2,r17
L_92a0e0:
	mov r18,sp
L_92a0e4:
	add_s r13,sp,0x8
L_92a0e6:
	mov_s r15,r16
	.global L_92a0e8
L_92a0e8:
	mov r0,0xff
L_92a0ec:
	bl.d L_928b8c
L_92a0f0:
	mov r1,r18
L_92a0f4:
	bl L_92a014
L_92a0f8:
	ldb r0,[sp]
L_92a0fc:
	bl.d L_928b8c
L_92a100:
	mov r1,0x0
L_92a104:
	mov r0,r13
L_92a108:
	bl.d L_934b8c
L_92a10c:
	mov r1,r17
L_92a110:
	bl.d L_928aac
L_92a114:
	mov r0,r13
L_92a118:
	breq_s r0,0,L_92a164
L_92a11a:
	add_s r14,sp,0x4
	.global L_92a11c
L_92a11c:
	bl.d L_92de8c
L_92a120:
	mov r0,r13
L_92a124:
	asl r3,0x1,r0
L_92a12c:
	extb r0,r3
L_92a130:
	bl.d L_928b8c
L_92a134:
	mov r1,0x0
L_92a138:
	mov r0,0x0
L_92a13c:
	mov r1,0x428
L_92a140:
	bl.d L_92a2a4
L_92a144:
	mov r2,r14
L_92a148:
	ldb r0,[sp]
L_92a14c:
	bl.d L_928b8c
L_92a150:
	mov r1,0x0
L_92a154:
	ld_s r2,[sp,0x4]
L_92a156:
	breq_s r2,0,L_92a16c
L_92a158:
	bl.d L_928aac
L_92a15c:
	mov r0,r13
L_92a160:
	brne r0,0x0,L_92a11c
	.global L_92a164
L_92a164:
	b.d L_92a174
L_92a168:
	ld r2,[sp, 0x4]
	.global L_92a16c
L_92a16c:
	stb r16,[gp, -0xe2]
L_92a170:
	add_s r15,r15,0xa
L_92a172:
	extb_s r15,r15
	.global L_92a174
L_92a174:
	brge r15,0x33,L_92a17c
L_92a178:
	breq r2,0x0,L_92a0e8
	.global L_92a17c
L_92a17c:
	mov_s r1,0x100202c
L_92a182:
	mov_s r0,0x29
L_92a184:
	bl.d L_92d27c
L_92a188:
	mov r3,r15
L_92a18c:
	ld_s r2,[sp,0x4]
L_92a18e:
	brne_s r2,0,L_92a1a0
L_92a190:
	mov r1,0x1002060
L_92a198:
	bl.d L_92d13c
L_92a19c:
	mov r0,0x9
	.global L_92a1a0
L_92a1a0:
	ldb r0,[sp]
L_92a1a4:
	bl.d L_928b8c
L_92a1a8:
	mov r1,0x0
L_92a1ac:
	stb r15,[gp, -0xe2]
L_92a1b0:
	add_s sp,sp,0xc
L_92a1b2:
	ld blink,[sp, 0x4]
L_92a1b6:
	ld_s r14,[sp,0x8]
L_92a1b8:
	ld_s r15,[sp,0xc]
L_92a1ba:
	ld r16,[sp, 0x10]
L_92a1be:
	ld r17,[sp, 0x14]
L_92a1c2:
	ld r18,[sp, 0x18]
L_92a1c6:
	j_s.d [blink]
L_92a1c8:
	ld.ab r13,[sp,0x1c]
