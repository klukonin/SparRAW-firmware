/* fw_log__emit2_nonl @ 0x8ee0ac, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile, hwf_rf_xpm_block_access_check_inputs, hwf_rf_xpm_single_byte_access_check_inputs
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__commit
 */
	.section .text.fw_log__emit2_nonl,"ax",@progbits
	.global fw_log__emit2_nonl
fw_log__emit2_nonl:
	.global L_8ee0ac
L_8ee0ac:
	push_s blink
L_8ee0ae:
	bl.d L_8c02c0
L_8ee0b2:
	mov_s r5,r2
L_8ee0b4:
	mov_s r15,0x843900
L_8ee0ba:
	add_s r2,r15,0x4
L_8ee0bc:
	ldb_s r2,[r2,r0]
L_8ee0be:
	mov_s r13,r4
L_8ee0c0:
	bbit0 r2,r1,L_8ee0e4
L_8ee0c4:
	ld_s r14,[r15]
L_8ee0c6:
	add_s r2,r14,0x2
L_8ee0c8:
	bmsk_s r2,r2,0x9
L_8ee0ca:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8ee0cc:
	add2 r2,r15,r2
L_8ee0d0:
	bmsk_s r14,r14,0x9
L_8ee0d2:
	st_s r13,[r2,0x14]
L_8ee0d4:
	add2_s r15,r15,r14
L_8ee0d6:
	st_s r3,[r15,0x14]
L_8ee0d8:
	mov_s r2,r5
L_8ee0da:
	mov_s r3,0x2
L_8ee0dc:
	bl.d L_8ee134
L_8ee0e0:
	mov r4,0x1
	.global L_8ee0e4
L_8ee0e4:
	b L_8c032c
