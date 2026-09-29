/* fw_log_emit1 @ 0x8dcc10, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: Calib__Measure_VGA_Gains, POWER_MNGR__deep_sleep_exit, POWER_MNGR__halt, POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, POWER_MNGR__wmi_traffic_deferral_cmd, PS_ASSOC_SM__ps_cancel_schd_reenter, PS_ASSOC_SM__ps_schd_reenter_extend, PS_CFG_SCHEME__switch_active_ps_profile, PS_CONNECTION__disassoc_ntf, PS_CONNECTION__psc_complete_8e1794
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_log_emit1
fw_log_emit1:
	.global L_8dcc10
L_8dcc10:
	push_s blink
L_8dcc12:
	bl L_8c01e4
L_8dcc16:
	mov_s r13,r1
L_8dcc18:
	bmsk r1,r0,0x3
L_8dcc1c:
	lsr_s r0,r0,0x4
L_8dcc1e:
	mov_s r14,0x843900
L_8dcc24:
	add_s r3,r14,0x4
L_8dcc26:
	ldb_s r1,[r3,r1]
L_8dcc28:
	bmsk_s r0,r0,0x1
L_8dcc2a:
	sub_s sp,sp,0x8
L_8dcc2c:
	bbit0 r1,r0,L_8dcc7a
L_8dcc30:
	ld_s r0,[r14]
L_8dcc32:
	mov_s r1,sp
L_8dcc34:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8dcc36:
	bmsk_s r0,r0,0x9
L_8dcc38:
	add2 r0,r14,r0
L_8dcc3c:
	st_s r2,[r0,0x14]
L_8dcc3e:
	mov_s r0,0x0
L_8dcc40:
	bl.d L_8e9900
L_8dcc44:
	mov_s r2,r0
L_8dcc46:
	ld_s r1,[sp,0x4]
L_8dcc48:
	mov_s r0,0xff
L_8dcc4a:
	cmp_s r1,r0
L_8dcc4c:
	ld_s r2,[r14]
L_8dcc4e:
	mov.cs r0,r1
L_8dcc52:
	add_s r1,r2,0x1
L_8dcc54:
	bmsk_s r1,r1,0x9
L_8dcc56:
	ld_s r3,[sp,0x0]
L_8dcc58:
	add2 r1,r14,r1
L_8dcc5c:
	st_s r3,[r1,0x14]
L_8dcc5e:
	bmsk_s r13,r13,0x13
L_8dcc60:
	bset_s r13,r13,0x1a
L_8dcc62:
	bset_s r13,r13,0x1d
L_8dcc64:
	bset_s r13,r13,0x1f
L_8dcc66:
	extb_s r0,r0
L_8dcc68:
	asl_s r0,r0,0x12
L_8dcc6a:
	or_s r13,r13,r0
L_8dcc6c:
	bmsk r0,r2,0x9
L_8dcc70:
	add2 r0,r14,r0
L_8dcc74:
	st_s r13,[r0,0x14]
L_8dcc76:
	/* add_s r2,0x3 */
	.byte 0x03,0xe2
L_8dcc78:
	st_s r2,[r14]
	.global L_8dcc7a
L_8dcc7a:
	b.d L_8c0254
L_8dcc7e:
	add_s sp,sp,0x8
