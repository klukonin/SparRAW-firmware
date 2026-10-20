/* calib_lo_leakage_step @ 0x8c6fd8, 312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_leakage_run
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, get_reg88a204_s1_w32, hwd_abif__get_agc_field, hwd_abif__rgf_88a200_8cc674, hwd_abif__set_agc_field, hwd_phy__read_status_pair, hwd_phy__rgf_883000_8cf74c
 */
	.section .text.calib_lo_leakage_step,"ax",@progbits
	.global calib_lo_leakage_step
calib_lo_leakage_step:
	.global L_8c6fd8
L_8c6fd8:
	push_s blink
L_8c6fda:
	bl L_8c02a8
L_8c6fde:
	sub_s sp,sp,0x8
L_8c6fe0:
	mov_s r16,r1
L_8c6fe2:
	bl.d L_8cc6cc
L_8c6fe6:
	mov_s r14,0x4
L_8c6fe8:
	mov_s r20,r0
L_8c6fea:
	mov_s r0,0x0
L_8c6fec:
	bset_s r0,r0,0xf
L_8c6fee:
	mov_s r1,0x1
L_8c6ff0:
	bl.d L_8cf74c
L_8c6ff4:
	mov_s r2,0x0
L_8c6ff6:
	mov_s r0,0x0
L_8c6ff8:
	bl.d L_8cc674
L_8c6ffc:
	mov_s r1,0x0
L_8c6ffe:
	mov_s r0,0x1
L_8c7000:
	bl.d L_8cc674
L_8c7004:
	mov_s r1,r20
L_8c7006:
	mov_s r0,sp
L_8c7008:
	bl.d L_8cf6f8
L_8c700c:
	mov_s r17,r0
L_8c700e:
	ld_s r0,[sp,0x4]
L_8c7010:
	mov_s r13,0x0
L_8c7012:
	bset_s r13,r13,0xe
L_8c7014:
	cmp_s r0,0x0
L_8c7016:
	add.ge r0,r0,r13
L_8c701a:
	asr.ge r0,r0,0xf
L_8c701e:
	bge_s L_8c7028
L_8c7020:
	sub r1,r13,r0
L_8c7024:
	asr_s r1,r1,0xf
L_8c7026:
	neg_s r0,r1
	.global L_8c7028
L_8c7028:
	abs_s r15,r0
L_8c702a:
	cmp_s r15,0x5
L_8c702c:
	mov r19,0x1
L_8c7030:
	sub.ls r19,r19,r19
L_8c7034:
	mov r18,0x1
L_8c7038:
	mov r21,0x4
	.global L_8c703c
L_8c703c:
	mov_s r0,r20
L_8c703e:
	mov_s r1,r18
L_8c7040:
	bl.d L_8cc834
L_8c7044:
	mov_s r2,0x1
L_8c7046:
	sub r1,r16,0x1
L_8c704a:
	add_s r1,r1,r18
L_8c704c:
	stb_s r0,[r1]
L_8c704e:
	sub r21,r21,0x1
L_8c7052:
	add r18,r18,0x1
L_8c7056:
	brhs.d r21,0x1,L_8c703c
L_8c705a:
	extb r18,r18
L_8c705e:
	b_s L_8c70fa
	.global L_8c7060
L_8c7060:
	sub r0,r16,0x20
L_8c7064:
	ld_s r1,[sp,0x4]
L_8c7066:
	extb_s r15,r15
L_8c7068:
	cmp_s r1,0x0
L_8c706a:
	add.ge r1,r1,r13
L_8c706e:
	asr.ge r1,r1,0xf
L_8c7072:
	bge_s L_8c707c
L_8c7074:
	sub r2,r13,r1
L_8c7078:
	asr_s r2,r2,0xf
L_8c707a:
	neg_s r1,r2
	.global L_8c707c
L_8c707c:
	add r18,r0,r14
L_8c7080:
	ldb r3,[r18, 0x1f]
L_8c7084:
	cmp_s r1,0x5
L_8c7086:
	add.gt r3,r3,0x1
L_8c708a:
	min.gt r3,r3,0x1f
L_8c708e:
	sub.le r3,r3,0x1
L_8c7092:
	max.le r3,r3,0x0
L_8c7096:
	extb_s r3,r3
L_8c7098:
	mov_s r0,r20
L_8c709a:
	mov_s r1,r14
L_8c709c:
	bl.d L_8cc3c8
L_8c70a0:
	mov_s r2,0x1
L_8c70a2:
	mov_s r0,0x0
L_8c70a4:
	bl.d L_8cc674
L_8c70a8:
	mov_s r1,r0
L_8c70aa:
	mov_s r0,0x1
L_8c70ac:
	bl.d L_8cc674
L_8c70b0:
	mov_s r1,r20
L_8c70b2:
	bl.d L_8cf6f8
L_8c70b6:
	mov_s r0,r17
L_8c70b8:
	ld_s r0,[sp,0x4]
L_8c70ba:
	cmp_s r0,0x0
L_8c70bc:
	add.ge r0,r0,r13
L_8c70c0:
	asr.ge r0,r0,0xf
L_8c70c4:
	bge_s L_8c70ce
L_8c70c6:
	sub r1,r13,r0
L_8c70ca:
	asr_s r1,r1,0xf
L_8c70cc:
	neg_s r0,r1
	.global L_8c70ce
L_8c70ce:
	abs_s r0,r0
L_8c70d0:
	cmp_s r15,r0
L_8c70d2:
	mov.cc r15,r0
L_8c70d6:
	bhs_s L_8c70e6
L_8c70d8:
	mov_s r0,r20
L_8c70da:
	mov_s r1,r14
L_8c70dc:
	mov_s r2,0x1
L_8c70de:
	bl.d L_8cc3c8
L_8c70e2:
	ldb r3,[r18, 0x1f]
	.global L_8c70e6
L_8c70e6:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8c70e8:
	extb_s r14,r14
L_8c70ea:
	brlo.d r15,0x6,L_8c70f6
L_8c70ee:
	mov_s r0,0x0
L_8c70f0:
	cmp_s r14,0x0
L_8c70f2:
	mov.gt r0,0x1
	.global L_8c70f6
L_8c70f6:
	extb r19,r0
	.global L_8c70fa
L_8c70fa:
	brne r19,0x0,L_8c7060
L_8c70fe:
	mov_s r0,0x0
L_8c7100:
	bset_s r0,r0,0xf
L_8c7102:
	mov_s r1,0x1
L_8c7104:
	bl.d L_8cf74c
L_8c7108:
	mov_s r2,0x65
L_8c710a:
	b.d L_8c02fc
L_8c710e:
	add_s sp,sp,0x8
