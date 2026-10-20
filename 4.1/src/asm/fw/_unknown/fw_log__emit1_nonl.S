/* fw_log__emit1_nonl @ 0x8ee080, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile, calib_mngr__engine_start, fw_sysassert_fatal, hwf_rf_check_rf_id
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__commit
 */
	.section .text.fw_log__emit1_nonl,"ax",@progbits
	.global fw_log__emit1_nonl
fw_log__emit1_nonl:
	.global L_8ee080
L_8ee080:
	push_s blink
L_8ee082:
	bl L_8c02c4
L_8ee086:
	mov_s r13,0x843900
L_8ee08c:
	add_s r14,r13,0x4
L_8ee08e:
	ldb_s r14,[r14,r0]
L_8ee090:
	bbit0 r14,r1,L_8ee0a6
L_8ee094:
	ld_s r14,[r13]
L_8ee096:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8ee098:
	bmsk_s r14,r14,0x9
L_8ee09a:
	add2_s r13,r13,r14
L_8ee09c:
	st_s r3,[r13,0x14]
L_8ee09e:
	mov_s r3,0x1
L_8ee0a0:
	bl.d L_8ee134
L_8ee0a4:
	mov_s r4,r3
	.global L_8ee0a6
L_8ee0a6:
	b L_8c0334
L_8ee0aa:
	nop_s
