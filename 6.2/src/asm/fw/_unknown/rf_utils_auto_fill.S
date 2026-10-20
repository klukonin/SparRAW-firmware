/* rf_utils_auto_fill @ 0x8e3060, 520 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rf_utils_auto_fill(): wrong input params; p_fill_info = 0x%x
 *   rf_utils_auto_fill(): Failed to read AUTO_FILL_BUSY for rfc_mask=0x%x
 *   hwd_rfc_auto_fill_verify(): verification failure: rf_mask=0x%x; sec=%d; sec_val=0x%x
 *   rf_utils_auto_fill(): busy timeout
 * Зовут его: rf_utils__auto_fill_8021c8, rf_utils__fill_default_patterns
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, hwd__args_to_regs, hwd_abif__dvs_rfca_cmd_enable, hwd_rfc_read_rgf, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_utils_auto_fill
rf_utils_auto_fill:
	.global L_8e3060
L_8e3060:
	push_s blink
L_8e3062:
	bl L_8c01c0
L_8e3066:
	mov.f r13,r0
L_8e306a:
	sub sp,sp,0x100
L_8e306e:
	mov_s r16,r1
L_8e3070:
	beq_s L_8e3078
L_8e3072:
	ldb_s r0,[r13,0x1]
L_8e3074:
	brlt r0,0x2,L_8e3088
	.global L_8e3078
L_8e3078:
	mov_s r1,0x1008cd4
L_8e307e:
	mov_s r0,0x0
L_8e3080:
	bl.d L_8dcc10
L_8e3084:
	mov_s r2,r13
L_8e3086:
	b_s L_8e325e
	.global L_8e3088
L_8e3088:
	asl_s r0,r0,0x8
L_8e308a:
	add3 r0,r0,0x53c
L_8e308e:
	lsr_s r0,r0,0x3
L_8e3090:
	bic r14,r0,0x3
L_8e3094:
	ldb_s r0,[r13,0x3]
L_8e3096:
	ldb_s r15,[r13,0x2]
L_8e3098:
	asl_s r0,r0,0x8
L_8e309a:
	or_s r15,r15,r0
L_8e309c:
	ldb_s r0,[r13,0xc]
L_8e309e:
	ld_s r1,[r13,0x4]
L_8e30a0:
	asl_s r0,r0,0x10
L_8e30a2:
	or_s r15,r15,r0
L_8e30a4:
	cmp_s r1,0x0
L_8e30a6:
	mov_s r0,0x0
L_8e30a8:
	mov.eq r1,r0
L_8e30ac:
	beq_s L_8e30c6
L_8e30ae:
	mov_s r0,sp
L_8e30b0:
	bl.d L_8c0380
L_8e30b4:
	mov_s r2,0x18
L_8e30b6:
	ldb_s r0,[r13,0x1]
L_8e30b8:
	mov_s r1,0x6
L_8e30ba:
	asl_s r0,r0,0x8
L_8e30bc:
	add3 r0,r0,0x524
L_8e30c0:
	lsr_s r0,r0,0x3
L_8e30c2:
	bic r14,r0,0x3
	.global L_8e30c6
L_8e30c6:
	add2 r0,sp,r1
L_8e30ca:
	st_s r15,[r0]
L_8e30cc:
	add_s r15,r1,0x1
L_8e30ce:
	extw_s r15,r15
L_8e30d0:
	mov_s r1,0x1
L_8e30d2:
	add2 r0,sp,r15
L_8e30d6:
	st_s r1,[r0]
L_8e30d8:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8e30da:
	extw_s r15,r15
L_8e30dc:
	ldb r20,[r13]
L_8e30e0:
	brlt.d r15,0x1,L_8e310a
L_8e30e4:
	mov_s r0,0x0
L_8e30e6:
	extw_s r15,r15
L_8e30e8:
	mov_s r17,r0
	.global L_8e30ea
L_8e30ea:
	add2 r2,sp,r17
L_8e30ee:
	ld_s r2,[r2]
L_8e30f0:
	mov_s r0,r20
L_8e30f2:
	mov_s r1,r14
L_8e30f4:
	bl.d L_8d338c
L_8e30f8:
	mov_s r3,0x0
L_8e30fa:
	/* add_s r14,0x4 */
	.byte 0x04,0xe6
L_8e30fc:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8e30fe:
	add r17,r17,0x1
L_8e3102:
	brhs.d r15,0x1,L_8e30ea
L_8e3106:
	extw r17,r17
	.global L_8e310a
L_8e310a:
	mov_s r1,0x0
L_8e310c:
	mov_s r0,r20
L_8e310e:
	b_s L_8e3118
	.global L_8e3110
L_8e3110:
	sub_s r2,r0,0x1
L_8e3112:
	and_s r0,r0,r2
L_8e3114:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e3116:
	extw_s r1,r1
	.global L_8e3118
L_8e3118:
	brne_s r0,0,L_8e3110
L_8e311a:
	cmp_s r1,0x1
L_8e311c:
	blt.d L_8e325e
L_8e3120:
	mov_s r0,0x1
L_8e3122:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8e3124:
	extw_s r1,r1
L_8e3126:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8e3128
L_8e3128:
	mov_s r18,r0
L_8e312a:
	mov_s r23,r1
L_8e312c:
	cmp_s r0,0x1
L_8e312e:
	sub r1,r20,0x1
L_8e3132:
	mov.le r2,r20
L_8e3136:
	ble_s L_8e3148
L_8e3138:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e313a:
	extw_s r0,r0
L_8e313c:
	mov_s lp_count,r0
L_8e313e:
	mov_s r2,r20
L_8e3140:
	lp L_8e3148
L_8e3144:
	and_s r2,r2,r1
L_8e3146:
	sub_s r1,r2,0x1
	.global L_8e3148
L_8e3148:
	bic r0,r2,r1
L_8e314c:
	extb_s r0,r0
L_8e314e:
	mov_s r21,r0
L_8e3150:
	mov_s r14,0x0
L_8e3152:
	bl.d L_8ce910
L_8e3156:
	mov_s r1,r14
L_8e3158:
	mov_s r0,0x1
L_8e315a:
	b_s L_8e3162
	.global L_8e315c
L_8e315c:
	bmsk_s r0,r0,0x0
L_8e315e:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e3160:
	extw_s r14,r14
	.global L_8e3162
L_8e3162:
	brge r14,0x2,L_8e319a
L_8e3166:
	breq_s r0,0,L_8e319a
L_8e3168:
	mov_s r0,0x0
L_8e316a:
	bl.d L_8d3588
L_8e316e:
	mov r1,0x4f0
L_8e3172:
	brne r0,0xdeadbeef,L_8e315c
L_8e317a:
	mov_s r1,0x1008d14
L_8e3180:
	mov_s r0,0x0
L_8e3182:
	bl.d L_8dcc10
L_8e3186:
	mov_s r2,r21
L_8e3188:
	brne r16,0x0,L_8e3190
	.global L_8e318c
L_8e318c:
	mov_s r0,0x0
L_8e318e:
	b_s L_8e3260
	.global L_8e3190
L_8e3190:
	mov_s r1,0x1565
L_8e3196:
	mov_s r0,blink
L_8e3198:
	b_s L_8e322e
	.global L_8e319a
L_8e319a:
	brne r0,0x0,L_8e3216
L_8e319e:
	ld_s r0,[r13,0x8]
L_8e31a0:
	breq r0,0x0,L_8e3242
L_8e31a4:
	ld r19,[r13, 0x4]
L_8e31a8:
	breq r19,0x0,L_8e3242
L_8e31ac:
	ldb_s r0,[r13,0x1]
L_8e31ae:
	cmp_s r0,0x1
L_8e31b0:
	mov_s r0,0x1
L_8e31b2:
	sub_s.ne r0,r0,r0
L_8e31b4:
	asl_s r0,r0,0xc
L_8e31b6:
	add r17,r0,0x1000
L_8e31be:
	ldb_s r0,[r13,0x2]
L_8e31c0:
	b_s L_8e31c8
	.global L_8e31c2
L_8e31c2:
	add r0,r22,0x1
L_8e31c6:
	extb_s r0,r0
	.global L_8e31c8
L_8e31c8:
	mov_s r22,r0
L_8e31ca:
	ldb_s r0,[r13,0x3]
L_8e31cc:
	brlt r0,r22,L_8e3242
L_8e31d0:
	mov_s r15,0x1
L_8e31d2:
	mov_s r14,0x0
L_8e31d4:
	b_s L_8e31e2
	.global L_8e31d6
L_8e31d6:
	asl_s r15,r15
L_8e31d8:
	extb_s r15,r15
L_8e31da:
	add r17,r17,0x4
L_8e31de:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e31e0:
	extb_s r14,r14
	.global L_8e31e2
L_8e31e2:
	brge r14,0x6,L_8e31c2
L_8e31e6:
	ldb_s r0,[r13,0xc]
L_8e31e8:
	tst_s r15,r0
L_8e31ea:
	beq_s L_8e31d6
L_8e31ec:
	mov_s r0,0x0
L_8e31ee:
	bl.d L_8d3588
L_8e31f2:
	mov_s r1,r17
L_8e31f4:
	mov_s r4,r0
L_8e31f6:
	ld.as r0,[r19,r14]
L_8e31fa:
	breq r0,r4,L_8e31d6
L_8e31fe:
	mov_s r1,0x1008c7c
L_8e3204:
	mov_s r0,0x0
L_8e3206:
	mov_s r2,r21
L_8e3208:
	bl.d L_8dcd00
L_8e320c:
	mov_s r3,r22
L_8e320e:
	brne r16,0x0,L_8e3234
	.global L_8e3212
L_8e3212:
	mov_s r0,0x0
L_8e3214:
	b_s L_8e3244
	.global L_8e3216
L_8e3216:
	mov_s r1,0x1008d5c
L_8e321c:
	bl.d L_8dcba8
L_8e3220:
	mov_s r0,0x0
L_8e3222:
	breq r16,0x0,L_8e318c
L_8e3226:
	mov_s r0,blink
L_8e3228:
	mov_s r1,0x1566
	.global L_8e322e
L_8e322e:
	bl L_8c9b28
L_8e3232:
	b_s L_8e318c
	.global L_8e3234
L_8e3234:
	mov_s r0,blink
L_8e3236:
	mov_s r1,0x1567
L_8e323c:
	bl L_8c9b28
L_8e3240:
	b_s L_8e3212
	.global L_8e3242
L_8e3242:
	mov_s r0,0x1
	.global L_8e3244
L_8e3244:
	cmp r16,0x0
L_8e3248:
	cmp.eq r0,0x0
L_8e324c:
	beq_s L_8e318c
L_8e324e:
	sub r1,r23,0x1
L_8e3252:
	cmp_s r1,0x0
L_8e3254:
	add r0,r18,0x1
L_8e3258:
	bhi.d L_8e3128
L_8e325c:
	extw_s r0,r0
	.global L_8e325e
L_8e325e:
	mov_s r0,0x1
	.global L_8e3260
L_8e3260:
	b.d L_8c020c
L_8e3264:
	add sp,sp,0x100
