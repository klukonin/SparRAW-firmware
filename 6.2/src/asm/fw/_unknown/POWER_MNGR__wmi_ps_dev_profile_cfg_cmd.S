/* POWER_MNGR__wmi_ps_dev_profile_cfg_cmd @ 0x8ec970, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    POWER_MNGR::wmi_ps_dev_profile_cfg_cmd(ps_profile = %d)
 *   <<---- [HOST EVENT] WMI_PS_DEV_PROFILE_CFG_EVENT status %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: PS_CFG_SCHEME__switch_active_ps_profile, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global POWER_MNGR__wmi_ps_dev_profile_cfg_cmd
POWER_MNGR__wmi_ps_dev_profile_cfg_cmd:
	.global L_8ec970
L_8ec970:
	push_s blink
L_8ec972:
	bl L_8c01dc
L_8ec976:
	sub_s sp,sp,0x4
L_8ec978:
	mov_s r14,r0
L_8ec97a:
	mov_s r16,r1
L_8ec97c:
	mov_s r15,r2
L_8ec97e:
	bl.d L_8c33d0
L_8ec982:
	mov_s r0,r2
L_8ec984:
	mov_s r13,r0
L_8ec986:
	mov_s r1,0x1002030
L_8ec98c:
	mov_s r0,0x2e
L_8ec98e:
	bl.d L_8dcc10
L_8ec992:
	ldb_s r2,[r14]
L_8ec994:
	ldb_s r0,[r14]
L_8ec996:
	bl.d L_8e8438
L_8ec99a:
	mov_s r1,r16
L_8ec99c:
	mov_s r2,r0
L_8ec99e:
	st_s r0,[r13]
L_8ec9a0:
	mov_s r1,0x100206c
L_8ec9a6:
	bl.d L_8dcc10
L_8ec9aa:
	mov_s r0,0x2e
L_8ec9ac:
	mov_s r2,0x0
L_8ec9ae:
	st_s r2,[sp,0x0]
L_8ec9b0:
	mov_s r0,r15
L_8ec9b2:
	mov_s r1,r13
L_8ec9b4:
	mov_s r3,0x191c
L_8ec9ba:
	mov r4,0x4
L_8ec9be:
	mov r5,r16
L_8ec9c2:
	mov_s r6,r2
L_8ec9c4:
	bl.d L_8e4fc4
L_8ec9c8:
	mov_s r7,r2
L_8ec9ca:
	b.d L_8c0244
L_8ec9ce:
	add_s sp,sp,0x4
