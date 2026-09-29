/* POWER_MNGR__wmi_ps_dev_profile_cfg_cmd @ 0x8e7a24, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    POWER_MNGR::wmi_ps_dev_profile_cfg_cmd(ps_profile = %d)
 *   <<---- [HOST EVENT] WMI_PS_DEV_PROFILE_CFG_EVENT status %d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: PS_CFG_SCHEME__switch_active_ps_profile, __ld_r16_to_r13_ret, __st_r16_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit1
 */
	.section .text.POWER_MNGR__wmi_ps_dev_profile_cfg_cmd,"ax",@progbits
	.global POWER_MNGR__wmi_ps_dev_profile_cfg_cmd
POWER_MNGR__wmi_ps_dev_profile_cfg_cmd:
	.global L_8e7a24
L_8e7a24:
	push_s blink
L_8e7a26:
	bl L_8c02bc
L_8e7a2a:
	mov_s r14,r0
L_8e7a2c:
	mov_s r16,r1
L_8e7a2e:
	mov_s r15,r2
L_8e7a30:
	bl.d L_8c2c38
L_8e7a34:
	mov_s r0,r2
L_8e7a36:
	mov_s r13,r0
L_8e7a38:
	mov_s r2,0x1002248
L_8e7a3e:
	mov_s r0,0xe
L_8e7a40:
	mov_s r1,0x2
L_8e7a42:
	bl.d L_8edfcc
L_8e7a46:
	ldb_s r3,[r14]
L_8e7a48:
	ldb_s r0,[r14]
L_8e7a4a:
	bl.d L_8e3338
L_8e7a4e:
	mov_s r1,r16
L_8e7a50:
	mov_s r3,r0
L_8e7a52:
	st_s r0,[r13]
L_8e7a54:
	mov_s r2,0x1002284
L_8e7a5a:
	mov_s r0,0xe
L_8e7a5c:
	bl.d L_8edfcc
L_8e7a60:
	mov_s r1,0x2
L_8e7a62:
	mov_s r0,r15
L_8e7a64:
	mov_s r1,r13
L_8e7a66:
	mov_s r2,0x0
L_8e7a68:
	mov_s r3,0x191c
L_8e7a6e:
	mov r4,0x4
L_8e7a72:
	mov r5,r16
L_8e7a76:
	mov_s r6,r2
L_8e7a78:
	bl.d L_8e0460
L_8e7a7c:
	mov_s r7,r2
L_8e7a7e:
	b L_8c0324
L_8e7a82:
	nop_s
