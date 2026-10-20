/* hwd_abif__tx_table_config_iftx_gain @ 0x8cfd18, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_config_iftx_gain
hwd_abif__tx_table_config_iftx_gain:
	.global L_8cfd18
L_8cfd18:
	push_s blink
L_8cfd1a:
	bl L_8c01e4
L_8cfd1e:
	mov_s r14,r0
L_8cfd20:
	brge.d r0,0x20,L_8cfd40
L_8cfd24:
	mov_s r13,r1
	.global L_8cfd26
L_8cfd26:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_8cfd28:
	/* add_s r14,0x3 */
	.byte 0x03,0xe6
L_8cfd2a:
	mov_s r0,0x88a004
L_8cfd30:
	add2_s r0,r0,r14
L_8cfd32:
	ld_s r1,[r0]
L_8cfd34:
	bic r1,r1,0x1f
L_8cfd38:
	or_s r13,r13,r1
L_8cfd3a:
	st_s r13,[r0]
L_8cfd3c:
	b L_8c0254
	.global L_8cfd40
L_8cfd40:
	mov_s r0,blink
L_8cfd42:
	mov_s r1,0x1126
L_8cfd48:
	bl L_8c9b28
L_8cfd4c:
	b_s L_8cfd26
L_8cfd4e:
	nop_s
