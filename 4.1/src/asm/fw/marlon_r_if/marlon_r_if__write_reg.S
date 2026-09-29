/* marlon_r_if__write_reg @ 0x8e7f60, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if.cpp
 * Зовут его: calib_silent_rssi__write_reg, fr_clr_mdm_crc_statistics, marlon_r_if_class__config_brp_sectors, silent_rssi__log_levels, temp_measure_step
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, marlon_r_if__write_verify, marlon_r_if__write_via_rfc
 */
	.section .text.marlon_r_if__write_reg,"ax",@progbits
	.global marlon_r_if__write_reg
marlon_r_if__write_reg:
	.global L_8e7f60
L_8e7f60:
	push_s blink
L_8e7f62:
	push_s r13
L_8e7f64:
	mov_s r5,r2
L_8e7f66:
	ld_s r13,[r0,0x4]
L_8e7f68:
	cmp_s r1,0xf
L_8e7f6a:
	mov.eq r13,0x0
L_8e7f6e:
	cmp_s r13,0x0
L_8e7f70:
	mov_s r2,0x1
L_8e7f72:
	mov.eq r4,r2
L_8e7f76:
	beq_s L_8e7f98
L_8e7f78:
	breq r13,0x1,L_8e7fa0
L_8e7f7c:
	breq r13,0x2,L_8e7f94
L_8e7f80:
	mov_s r0,blink
L_8e7f82:
	mov_s r2,0x1005078
L_8e7f88:
	mov_s r1,0x53
L_8e7f8a:
	bset_s r1,r1,0xc
L_8e7f8c:
	bl.d L_8c82c0
L_8e7f90:
	mov_s r3,0xbc
L_8e7f92:
	b_s L_8e7faa
	.global L_8e7f94
L_8e7f94:
	ldb r4,[gp, 0xb3]
	.global L_8e7f98
L_8e7f98:
	bl.d L_8e7fb0
L_8e7f9c:
	mov_s r2,r5
L_8e7f9e:
	b_s L_8e7faa
	.global L_8e7fa0
L_8e7fa0:
	ldb r4,[gp, 0xb3]
L_8e7fa4:
	bl.d L_8e8014
L_8e7fa8:
	mov_s r2,r5
	.global L_8e7faa
L_8e7faa:
	b L_8c033c
L_8e7fae:
	nop_s
