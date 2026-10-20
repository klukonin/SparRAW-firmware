/* PS_CFG_SCHEME__switch_active_ps_profile @ 0x8e8438, 136 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1_tsf, fw_log__emit2_tsf, fw_log_emit1, ps_cfg__apply_profile_0, ps_cfg__apply_profile_1, ps_cfg__profile_matches
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global PS_CFG_SCHEME__switch_active_ps_profile
PS_CFG_SCHEME__switch_active_ps_profile:
	.global L_8e8438
L_8e8438:
	push_s blink
L_8e843a:
	bl L_8c01e0
L_8e843e:
	mov_s r14,r0
L_8e8440:
	bl.d L_8da4a8
L_8e8444:
	mov_s r13,0x0
L_8e8446:
	mov_s r2,0x800a4c
L_8e844c:
	add2 r15,r2,r14
L_8e8450:
	ld_s r3,[r15]
L_8e8452:
	breq_s r0,0,L_8e8466
L_8e8454:
	mov_s r1,0x10020cc
L_8e845a:
	mov_s r0,0x2e
L_8e845c:
	bl.d L_8dcd90
L_8e8460:
	mov_s r2,r3
L_8e8462:
	mov_s r0,r13
L_8e8464:
	b_s L_8e84bc
	.global L_8e8466
L_8e8466:
	mov_s r0,0x803d5c
L_8e846c:
	ld_s r0,[r0,0x24]
L_8e846e:
	mov_s r1,0x1002110
L_8e8474:
	ld.as r2,[r2,r0]
L_8e8478:
	bl.d L_8dce04
L_8e847c:
	mov_s r0,0x2e
L_8e847e:
	breq_s r14,0,L_8e849c
L_8e8480:
	breq r14,0x1,L_8e84a4
L_8e8484:
	cmp_s r14,0x2
L_8e8486:
	cmp.ne r14,0x3
L_8e848a:
	beq_s L_8e84ac
L_8e848c:
	mov_s r1,0x1002158
L_8e8492:
	mov_s r0,0xe
L_8e8494:
	bl.d L_8dcc10
L_8e8498:
	mov_s r2,r14
L_8e849a:
	b_s L_8e84ba
	.global L_8e849c
L_8e849c:
	bl L_8e6d4c
L_8e84a0:
	mov_s r0,r13
L_8e84a2:
	b_s L_8e84bc
	.global L_8e84a4
L_8e84a4:
	bl L_8e6da4
L_8e84a8:
	mov_s r0,r13
L_8e84aa:
	b_s L_8e84bc
	.global L_8e84ac
L_8e84ac:
	mov_s r1,0x1002198
L_8e84b2:
	mov_s r0,0xe
L_8e84b4:
	bl.d L_8dcd90
L_8e84b8:
	ld_s r2,[r15]
	.global L_8e84ba
L_8e84ba:
	mov_s r0,0x1
	.global L_8e84bc
L_8e84bc:
	b L_8c024c
