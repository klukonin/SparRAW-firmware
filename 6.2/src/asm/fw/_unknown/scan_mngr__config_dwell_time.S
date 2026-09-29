/* scan_mngr__config_dwell_time @ 0x8f1d14, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::config_dwell_time() pf_mode_en
 *   scan_mngr::config_dwell_time() Configuring dwell time according to special configuration
 *   scan_mngr::config_dwell_time() Configuring dwelltime for dwell time %d ms * num of AP dOMNI (%d) +  DWELL_TIME_GUARD_USEC = %d
 *   scan_mngr::config_dwell_time() Configuring dwell time for default scan (100ms) * num of AP dOMNI (%d) + DWELL_TIME_GUARD_USEC = %d
 * Зовут его: scan_mngr__start_scan
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_divmod_unsigned, fw_log_emit0, fw_log_emit2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__config_dwell_time
scan_mngr__config_dwell_time:
	.global L_8f1d14
L_8f1d14:
	push_s blink
L_8f1d16:
	bl L_8c01e4
L_8f1d1a:
	mov_s r13,r0
L_8f1d1c:
	mov_s r14,r1
L_8f1d1e:
	mov_s r1,0x803c00
L_8f1d24:
	ld_s r0,[r1,0xc]
L_8f1d26:
	breq_s r0,0,L_8f1d40
L_8f1d28:
	mov_s r1,0x1014f00
L_8f1d2e:
	bl.d L_8dcba8
L_8f1d32:
	mov_s r0,0x29
L_8f1d34:
	mov_s r0,0x8004e4
L_8f1d3a:
	ld_s r0,[r0]
L_8f1d3c:
	st_s r0,[r13,0x70]
L_8f1d3e:
	b_s L_8f1dc0
	.global L_8f1d40
L_8f1d40:
	ld_s r0,[r1,0x20]
L_8f1d42:
	bbit0 r0,0x7,L_8f1d5c
L_8f1d46:
	mov_s r1,0x1014f2c
L_8f1d4c:
	bl.d L_8dcba8
L_8f1d50:
	mov_s r0,0x29
L_8f1d52:
	st 0x7a120,[r13, 0x70]
L_8f1d5a:
	b_s L_8f1dc0
	.global L_8f1d5c
L_8f1d5c:
	st 0x1388,[r13, 0x70]
L_8f1d64:
	mov_s r0,0x1388
L_8f1d6a:
	ldb r1,[gp, 0xad]
L_8f1d6e:
	breq_s r14,0,L_8f1d9a
L_8f1d70:
	mulu64 r14,0x3e8
L_8f1d74:
	mulu64 mlo,r1
L_8f1d78:
	add_s r0,r0,mlo
L_8f1d7a:
	st_s r0,[r13,0x70]
L_8f1d7c:
	bl.d L_8c02d4
L_8f1d80:
	mov r1,0x3e8
L_8f1d84:
	mov_s r4,r0
L_8f1d86:
	mov_s r1,0x1014f88
L_8f1d8c:
	mov_s r0,0x29
L_8f1d8e:
	mov_s r2,r14
L_8f1d90:
	bl.d L_8dcd00
L_8f1d94:
	ldb r3,[gp, 0xad]
L_8f1d98:
	b_s L_8f1dc0
	.global L_8f1d9a
L_8f1d9a:
	/* mul64 r1,0x186a0 */
	.byte 0x04,0x29,0x81,0x0f,0x01,0x00,0xa0,0x86
L_8f1da2:
	add_s r0,r0,mlo
L_8f1da4:
	st_s r0,[r13,0x70]
L_8f1da6:
	bl.d L_8c02d4
L_8f1daa:
	mov r1,0x3e8
L_8f1dae:
	mov_s r3,r0
L_8f1db0:
	mov_s r1,0x1015008
L_8f1db6:
	mov_s r0,0x29
L_8f1db8:
	bl.d L_8dcc80
L_8f1dbc:
	ldb r2,[gp, 0xad]
	.global L_8f1dc0
L_8f1dc0:
	b L_8c0254
