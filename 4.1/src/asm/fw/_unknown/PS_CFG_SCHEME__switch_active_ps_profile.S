/* PS_CFG_SCHEME__switch_active_ps_profile @ 0x8e3338, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CFG_SCHEME::switch_active_ps_profile: %s is already configured
 *   PS_CFG_SCHEME::switch_active_ps_profile: current profile: %s next: %s
 *   PS_CFG_SCHEME::switch_active_ps_profile: %d invalid PS-Profile
 *   PS_CFG_SCHEME::switch_active_ps_profile: %s is not supported
 * Зовут его: POWER_MNGR__wmi_ps_dev_profile_cfg_cmd
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, fw_log__emit1_nonl, fw_log__emit2_nonl, ps_cfg__apply_profile, ps_cfg__find_profile, ps_cfg__load_profile
 */
	.section .text.PS_CFG_SCHEME__switch_active_ps_profile,"ax",@progbits
	.global PS_CFG_SCHEME__switch_active_ps_profile
PS_CFG_SCHEME__switch_active_ps_profile:
	.global L_8e3338
L_8e3338:
	push_s blink
L_8e333a:
	bl L_8c02c0
L_8e333e:
	mov_s r14,r0
L_8e3340:
	bl.d L_8d73e4
L_8e3344:
	mov_s r13,0x0
L_8e3346:
	mov_s r1,0x8009b0
L_8e334c:
	add2 r15,r1,r14
L_8e3350:
	ld r4,[r15]
L_8e3354:
	breq_s r0,0,L_8e336a
L_8e3356:
	mov_s r2,0x1002374
L_8e335c:
	mov_s r0,0xe
L_8e335e:
	mov_s r1,0x2
L_8e3360:
	bl.d L_8ee080
L_8e3364:
	mov_s r3,r4
L_8e3366:
	mov_s r0,r13
L_8e3368:
	b_s L_8e33c6
	.global L_8e336a
L_8e336a:
	mov_s r0,0x8035c8
L_8e3370:
	ld_s r0,[r0,0x24]
L_8e3372:
	mov_s r2,0x10023b8
L_8e3378:
	ld.as r3,[r1,r0]
L_8e337c:
	mov_s r0,0xe
L_8e337e:
	bl.d L_8ee0ac
L_8e3382:
	mov_s r1,0x2
L_8e3384:
	breq_s r14,0,L_8e33a4
L_8e3386:
	breq r14,0x1,L_8e33ac
L_8e338a:
	cmp_s r14,0x2
L_8e338c:
	cmp.ne r14,0x3
L_8e3390:
	beq_s L_8e33b4
L_8e3392:
	mov_s r2,0x1002400
L_8e3398:
	mov_s r0,0xe
L_8e339a:
	mov_s r1,r13
L_8e339c:
	bl.d L_8edfcc
L_8e33a0:
	mov_s r3,r14
L_8e33a2:
	b_s L_8e33c4
	.global L_8e33a4
L_8e33a4:
	bl L_8e1f3c
L_8e33a8:
	mov_s r0,r13
L_8e33aa:
	b_s L_8e33c6
	.global L_8e33ac
L_8e33ac:
	bl L_8e1f8c
L_8e33b0:
	mov_s r0,r13
L_8e33b2:
	b_s L_8e33c6
	.global L_8e33b4
L_8e33b4:
	mov_s r2,0x1002440
L_8e33ba:
	mov_s r0,0xe
L_8e33bc:
	mov_s r1,0x0
L_8e33be:
	bl.d L_8ee080
L_8e33c2:
	ld_s r3,[r15]
	.global L_8e33c4
L_8e33c4:
	mov_s r0,0x1
	.global L_8e33c6
L_8e33c6:
	.byte 0x69,0x07
