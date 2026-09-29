/* calib_lo_leakage_substep @ 0x8d8eac, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_leakage_run
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, get_reg88a204_s1_w32, hwd_abif__rgf_88a200_8cc674, hwd_abif__set_agc_field, hwd_phy__get_883700_8cf970, hwd_phy__rgf_883000_8cf4c8, hwd_phy__set_mode, set_reg_883150
 */
	.section .text.calib_lo_leakage_substep,"ax",@progbits
	.global calib_lo_leakage_substep
calib_lo_leakage_substep:
	.global L_8d8eac
L_8d8eac:
	push_s blink
L_8d8eae:
	bl L_8c02b8
L_8d8eb2:
	bl.d L_8cc6cc
L_8d8eb6:
	mov_s r15,r1
L_8d8eb8:
	mov_s r16,r0
L_8d8eba:
	bl.d L_8cf588
L_8d8ebe:
	mov_s r0,0x1
L_8d8ec0:
	bl.d L_8cf958
L_8d8ec4:
	mov_s r0,0x0
L_8d8ec6:
	bl.d L_8cf4c8
L_8d8eca:
	mov_s r0,0x0
L_8d8ecc:
	bl.d L_8cf4c8
L_8d8ed0:
	mov_s r0,0x1
L_8d8ed2:
	mov_s r0,0x32
L_8d8ed4:
	mov lp_count,r0
L_8d8ed8:
	nop_s
L_8d8eda:
	lp L_8d8ee2
L_8d8ede:
	nop_s
L_8d8ee0:
	nop_s
	.global L_8d8ee2
L_8d8ee2:
	bl.d L_8cf970
L_8d8ee6:
	mov_s r13,0x4
L_8d8ee8:
	sub_s r0,r0,0x14
L_8d8eea:
	add_s r0,r0,r16
L_8d8eec:
	cmp_s r0,0xa
L_8d8eee:
	mov r4,0xa
L_8d8ef2:
	mov.hi r4,r0
L_8d8ef6:
	extb r4,r4
L_8d8efa:
	min r4,r4,0x3f
L_8d8efe:
	extb r17,r4
L_8d8f02:
	mov_s r0,0x0
L_8d8f04:
	bl.d L_8cc674
L_8d8f08:
	mov_s r1,r0
L_8d8f0a:
	mov_s r0,0x1
L_8d8f0c:
	bl.d L_8cc674
L_8d8f10:
	mov_s r1,r17
L_8d8f12:
	bl.d L_8cf588
L_8d8f16:
	mov_s r0,0x0
L_8d8f18:
	bl.d L_8cf4c8
L_8d8f1c:
	mov_s r0,0x0
L_8d8f1e:
	mov_s r14,0x1
	.global L_8d8f20
L_8d8f20:
	sub_s r0,r15,0x1
L_8d8f22:
	ldb_s r3,[r0,r14]
L_8d8f24:
	mov_s r0,r16
L_8d8f26:
	mov_s r1,r14
L_8d8f28:
	bl.d L_8cc3c8
L_8d8f2c:
	mov_s r2,0x1
L_8d8f2e:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d8f30:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d8f32:
	brhs.d r13,0x1,L_8d8f20
L_8d8f36:
	extb_s r14,r14
L_8d8f38:
	b L_8c031c
