/* rfca__touch_rf_module @ 0x8e2fc0, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib__classify_by_thresholds, deep_sleep_exit, rf__restore_if_needed
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_abif__dvs_rfca_cmd_enable, rf_tbl__lookup_by_module
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfca__touch_rf_module
rfca__touch_rf_module:
	.global L_8e2fc0
L_8e2fc0:
	push_s blink
L_8e2fc2:
	push_s r13
L_8e2fc4:
	mov.f r13,r2
L_8e2fc8:
	mov_s r0,0x0
L_8e2fca:
	stb.a r0,[sp,-0x4]
L_8e2fce:
	beq_s L_8e2fde
L_8e2fd0:
	mov_s r0,0x0
L_8e2fd2:
	bset r0,r0,r1
L_8e2fd6:
	extb_s r0,r0
L_8e2fd8:
	bl.d L_8ce910
L_8e2fdc:
	mov_s r1,sp
	.global L_8e2fde
L_8e2fde:
	breq_s r13,0,L_8e2fe8
L_8e2fe0:
	ldb_s r0,[sp,0x0]
L_8e2fe2:
	bl.d L_8ce910
L_8e2fe6:
	mov_s r1,0x0
	.global L_8e2fe8
L_8e2fe8:
	b.d L_8c025c
L_8e2fec:
	add_s sp,sp,0x4
L_8e2fee:
	nop_s
L_8e2ff0:
	push_s blink
L_8e2ff2:
	bl L_8c01e0
L_8e2ff6:
	mov_s r14,r1
L_8e2ff8:
	mov_s r1,0x857700
L_8e2ffe:
	ld_s r1,[r1,0x68]
L_8e3000:
	sub_s sp,sp,0x4
L_8e3002:
	brlo.d r1,0x2,L_8e305a
L_8e3006:
	mov_s r15,r2
L_8e3008:
	ldb_s r1,[r14,0x15]
L_8e300a:
	brge r1,0x2,L_8e305a
L_8e300e:
	cmp_s r1,0x0
L_8e3010:
	mov_s r2,0x1
L_8e3012:
	ld_s r3,[r0,0x48]
L_8e3014:
	sub_s.ne r2,r2,r2
L_8e3016:
	ld_s r1,[r14,0x8]
L_8e3018:
	add_s r3,r3,0x8
L_8e301a:
	add_s r1,r1,0xc
L_8e301c:
	ld_s r13,[r1,r3]
L_8e301e:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8e3020:
	extw_s r15,r15
L_8e3022:
	ldb_s r1,[r14,0x14]
L_8e3024:
	brlt.d r15,0x2,L_8e303a
L_8e3028:
	sub_s r3,r1,0x1
L_8e302a:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8e302c:
	extw lp_count,r15
L_8e3030:
	nop_s
L_8e3032:
	lp L_8e303a
L_8e3036:
	and_s r1,r1,r3
L_8e3038:
	sub_s r3,r1,0x1
	.global L_8e303a
L_8e303a:
	bic_s r1,r1,r3
L_8e303c:
	extb_s r1,r1
L_8e303e:
	mov_s r3,0x0
L_8e3040:
	stb_s r3,[sp,0x0]
L_8e3042:
	stb r3,[sp, 0x1]
L_8e3046:
	mov_s r3,sp
L_8e3048:
	bl.d L_8cca88
L_8e304c:
	add r4,sp,0x1
L_8e3050:
	ldb_s r0,[sp,0x0]
L_8e3052:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_8e3054:
	add1_s r0,r0,r0
L_8e3056:
	add_s r13,r13,r0
L_8e3058:
	st_s r13,[r14,0x10]
	.global L_8e305a
L_8e305a:
	b.d L_8c024c
L_8e305e:
	add_s sp,sp,0x4
