/* hwd_abif__tx_table_config_tx_mixer_gate_ctrl @ 0x8cfe24, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_config_tx_mixer_gate_ctrl
hwd_abif__tx_table_config_tx_mixer_gate_ctrl:
	.global L_8cfe24
L_8cfe24:
	push_s blink
L_8cfe26:
	bl L_8c01dc
L_8cfe2a:
	mov_s r14,r0
L_8cfe2c:
	brge.d r0,0x20,L_8cfe50
L_8cfe30:
	mov_s r16,r1
	.global L_8cfe32
L_8cfe32:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_8cfe34:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_8cfe36:
	mov_s r0,0x88a004
L_8cfe3c:
	add2_s r0,r0,r14
L_8cfe3e:
	ld_s r1,[r0]
L_8cfe40:
	asl r13,r16,0x4
L_8cfe44:
	bic r1,r1,0x1f0
L_8cfe48:
	or_s r13,r13,r1
L_8cfe4a:
	st_s r13,[r0]
L_8cfe4c:
	b L_8c0244
	.global L_8cfe50
L_8cfe50:
	mov_s r0,blink
L_8cfe52:
	bl.d L_8c9b28
L_8cfe56:
	mov_s r1,0x20
L_8cfe58:
	b_s L_8cfe32
L_8cfe5a:
	nop_s
