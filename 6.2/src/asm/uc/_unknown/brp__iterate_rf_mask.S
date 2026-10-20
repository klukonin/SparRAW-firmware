/* brp__iterate_rf_mask @ 0x92efc8, 408 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__read_rf_id
 * Зовёт сам: rf__write_sector_awv, rfca__select_rf_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__iterate_rf_mask
brp__iterate_rf_mask:
	.global L_92efc8
L_92efc8:
	st.a r13,[sp,-0x2c]
L_92efcc:
	st blink,[sp, 0x4]
L_92efd0:
	st_s r14,[sp,0x8]
L_92efd2:
	st_s r15,[sp,0xc]
L_92efd4:
	st r16,[sp, 0x10]
L_92efd8:
	st r17,[sp, 0x14]
L_92efdc:
	st r18,[sp, 0x18]
L_92efe0:
	st r19,[sp, 0x1c]
L_92efe4:
	st r20,[sp, 0x20]
L_92efe8:
	st r21,[sp, 0x24]
L_92efec:
	mov.f r20,r0
L_92eff0:
	st r22,[sp, 0x28]
L_92eff4:
	beq.d L_92f014
L_92eff8:
	mov r21,0x0
L_92effc:
	mov r6,r20
	.global L_92f000
L_92f000:
	sub r5,r6,0x1
L_92f004:
	and.f r6,r6,r5
L_92f008:
	add r21,r21,0x1
L_92f00c:
	bne.d L_92f000
L_92f010:
	extw r21,r21
	.global L_92f014
L_92f014:
	cmp r21,0x1
L_92f018:
	blt.d L_92f134
L_92f01c:
	mov r19,0x1
L_92f020:
	mov r22,0x857800
L_92f028:
	sub r22,r22,0x94
L_92f02c:
	sub r21,r21,0x1
L_92f030:
	extw r21,r21
L_92f034:
	add r21,r21,0x1
	.global L_92f038
L_92f038:
	cmp r19,0x1
L_92f03c:
	mov r18,0x6
L_92f040:
	ble.d L_92f064
L_92f044:
	mov.le r13,r20
L_92f048:
	sub r5,r19,0x1
L_92f04c:
	extw r5,r5
L_92f050:
	mov lp_count,r5
L_92f054:
	mov r13,r20
L_92f058:
	lp L_92f064
L_92f05c:
	sub r4,r13,0x1
L_92f060:
	and r13,r13,r4
	.global L_92f064
L_92f064:
	sub r4,r13,0x1
L_92f068:
	bic r13,r13,r4
L_92f06c:
	extb_s r13,r13
L_92f06e:
	mov_s r0,r13
L_92f070:
	bl.d L_928b8c
L_92f074:
	mov r1,0x0
L_92f078:
	mov_s r14,0x13
L_92f07a:
	asl_s r14,r14,0x9
L_92f07c:
	cmp_s r13,0x8
L_92f07e:
	mov_s r3,0x0
L_92f080:
	mov.gt r3,0x4
L_92f084:
	lsr.gt r13,r13,0x4
L_92f088:
	brlt r13,0x3,L_92f094
L_92f08c:
	/* add_s r3,0x2 */
	.byte 0x02,0xe3
L_92f08e:
	extb_s r3,r3
L_92f090:
	lsr r13,r13,0x2
	.global L_92f094
L_92f094:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_92f096:
	add_s r3,r3,r13
L_92f098:
	extb r3,r3
L_92f09c:
	ld.as r17,[r22,r3]
L_92f0a0:
	breq.d r17,0x0,L_92f0bc
L_92f0a4:
	mov_s r13,0x0
L_92f0a6:
	mov_s r3,r17
	.global L_92f0a8
L_92f0a8:
	sub r4,r3,0x1
L_92f0ac:
	and.f r3,r3,r4
L_92f0b0:
	add r13,r13,0x1
L_92f0b4:
	bne.d L_92f0a8
L_92f0b8:
	extw r13,r13
	.global L_92f0bc
L_92f0bc:
	breq.d r13,0x0,L_92f120
L_92f0c0:
	mov r15,0x0
	.global L_92f0c4
L_92f0c4:
	asl r16,0x1,r15
L_92f0cc:
	tst r16,r17
L_92f0d0:
	beq L_92f118
L_92f0d4:
	add r0,r14,0x14
L_92f0d8:
	bl.d L_92fa6c
L_92f0dc:
	mov r1,r16
L_92f0e0:
	add r0,r14,0x8
L_92f0e4:
	bl.d L_92fa6c
L_92f0e8:
	mov r1,r16
L_92f0ec:
	lsr r2,r15,0x2
L_92f0f0:
	add1_s r2,r2,r2
L_92f0f2:
	asl r1,r18,r2
L_92f0f6:
	add r0,r14,0x10
L_92f0fa:
	cmp_s r15,0xf
L_92f0fc:
	add.ls r1,r1,0x10000000
L_92f104:
	add.hi r1,r1,0x20000000
L_92f10c:
	bl.d L_92fa6c
L_92f110:
	add r14,r14,0x18
L_92f114:
	sub r13,r13,0x1
	.global L_92f118
L_92f118:
	brne.d r13,0x0,L_92f0c4
L_92f11c:
	add r15,r15,0x1
	.global L_92f120
L_92f120:
	sub r21,r21,0x1
L_92f124:
	cmp r21,0x0
L_92f128:
	add r19,r19,0x1
L_92f12c:
	bhi.d L_92f038
L_92f130:
	extw r19,r19
	.global L_92f134
L_92f134:
	ld blink,[sp, 0x4]
L_92f138:
	ld_s r14,[sp,0x8]
L_92f13a:
	ld_s r15,[sp,0xc]
L_92f13c:
	ld r16,[sp, 0x10]
L_92f140:
	ld r17,[sp, 0x14]
L_92f144:
	ld r18,[sp, 0x18]
L_92f148:
	ld r19,[sp, 0x1c]
L_92f14c:
	ld r20,[sp, 0x20]
L_92f150:
	ld r21,[sp, 0x24]
L_92f154:
	ld r22,[sp, 0x28]
L_92f158:
	j.d [blink]
L_92f15c:
	ld.ab r13,[sp,0x2c]
