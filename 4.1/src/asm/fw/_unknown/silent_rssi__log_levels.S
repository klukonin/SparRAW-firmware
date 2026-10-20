/* silent_rssi__log_levels @ 0x8de9f8, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_deep_sleep_exit_step, silent_rssi__classify_levels
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, marlon_r_if__write_reg
 */
	.section .text.silent_rssi__log_levels,"ax",@progbits
	.global silent_rssi__log_levels
silent_rssi__log_levels:
	.global L_8de9f8
L_8de9f8:
	push_s blink
L_8de9fa:
	bl.d L_8c02b8
L_8de9fe:
	mov_s r2,0x58
L_8dea00:
	mov_s r14,0x803e84
L_8dea06:
	mov_s r13,0x800d14
L_8dea0c:
	add r17,r13,0x2c
L_8dea10:
	mov r16,0x800d54
L_8dea18:
	ldb r1,[r16, 0x13]
L_8dea1c:
	add_s r0,r13,0x4
L_8dea1e:
	ld.as r3,[r0,r1]
L_8dea22:
	mov_s r0,r14
L_8dea24:
	bl.d L_8e7f60
L_8dea28:
	ldb_s r1,[r14]
L_8dea2a:
	add_s r13,r13,0x18
L_8dea2c:
	ldb r0,[r16, 0x14]
L_8dea30:
	ld.as r3,[r13,r0]
L_8dea34:
	mov_s r0,r14
L_8dea36:
	ldb_s r1,[r14]
L_8dea38:
	bl.d L_8e7f60
L_8dea3c:
	mov_s r2,0x78
L_8dea3e:
	mov_s r13,0x0
L_8dea40:
	mov_s r15,0x5
	.global L_8dea42
L_8dea42:
	asl_s r0,r13,0x5
L_8dea44:
	add r0,r0,0x140
L_8dea48:
	lsr_s r0,r0,0x3
L_8dea4a:
	bic r2,r0,0x3
L_8dea4e:
	ldb r0,[r16, 0x15]
L_8dea52:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8dea54:
	add_s r0,r0,r13
L_8dea56:
	ld.as r3,[r17,r0]
L_8dea5a:
	mov_s r0,r14
L_8dea5c:
	bl.d L_8e7f60
L_8dea60:
	ldb_s r1,[r14]
L_8dea62:
	/* brhs.d r15,0x1,0x008dea42 */
	.byte 0xe3,0x0f,0x75,0x90
L_8dea66:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8dea68:
	b L_8c031c
