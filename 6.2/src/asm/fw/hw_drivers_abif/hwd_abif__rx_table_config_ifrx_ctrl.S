/* hwd_abif__rx_table_config_ifrx_ctrl @ 0x8cf0f8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_if_gain__apply_agc_table
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_config_ifrx_ctrl
hwd_abif__rx_table_config_ifrx_ctrl:
	.global L_8cf0f8
L_8cf0f8:
	push_s blink
L_8cf0fa:
	bl L_8c01dc
L_8cf0fe:
	mov_s r13,r0
L_8cf100:
	cmp_s r0,0x40
L_8cf102:
	mov_s r14,r1
L_8cf104:
	mov_s r15,r2
L_8cf106:
	bge_s L_8cf126
	.global L_8cf108
L_8cf108:
	mov r16,0x0
L_8cf10c:
	breq r14,0x1,L_8cf132
L_8cf110:
	breq r14,0x2,L_8cf136
L_8cf114:
	breq r14,0x3,L_8cf13a
L_8cf118:
	mov_s r0,blink
L_8cf11a:
	mov_s r1,0xfe
L_8cf11c:
	bl.d L_8c9b28
L_8cf120:
	bset_s r1,r1,0xc
L_8cf122:
	mov_s r1,r16
L_8cf124:
	b_s L_8cf13c
	.global L_8cf126
L_8cf126:
	mov_s r0,blink
L_8cf128:
	mov_s r1,0xfd
L_8cf12a:
	bl.d L_8c9b28
L_8cf12e:
	bset_s r1,r1,0xc
L_8cf130:
	b_s L_8cf108
	.global L_8cf132
L_8cf132:
	mov_s r1,0x11
L_8cf134:
	b_s L_8cf13c
	.global L_8cf136
L_8cf136:
	mov_s r1,0x15
L_8cf138:
	b_s L_8cf13c
	.global L_8cf13a
L_8cf13a:
	mov_s r1,0x19
	.global L_8cf13c
L_8cf13c:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cf13e:
	/* add_s r13,0x3 */
	.byte 0x03,0xe5
L_8cf140:
	mov_s r0,0x88a208
L_8cf146:
	add2_s r0,r0,r13
L_8cf148:
	ld_s r3,[r0]
L_8cf14a:
	mov_s r2,0xf
L_8cf14c:
	asl_s r2,r2,r1
L_8cf14e:
	bic_s r3,r3,r2
L_8cf150:
	asl_s r15,r15,r1
L_8cf152:
	or_s r3,r3,r15
L_8cf154:
	st_s r3,[r0]
L_8cf156:
	b L_8c0244
L_8cf15a:
	nop_s
