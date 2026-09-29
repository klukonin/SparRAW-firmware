/* hwd_abif__tx_table_config_xif_ctrl @ 0x8cfe5c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_config_xif_ctrl
hwd_abif__tx_table_config_xif_ctrl:
	.global L_8cfe5c
L_8cfe5c:
	push_s blink
L_8cfe5e:
	bl L_8c01dc
L_8cfe62:
	mov_s r14,r0
L_8cfe64:
	brge.d r0,0x20,L_8cfe8c
L_8cfe68:
	mov_s r16,r1
	.global L_8cfe6a
L_8cfe6a:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_8cfe6c:
	/* add_s r14,0x3 */
	.byte 0x03,0xe6
L_8cfe6e:
	mov_s r0,0x88a004
L_8cfe74:
	add2_s r0,r0,r14
L_8cfe76:
	ld_s r1,[r0]
L_8cfe78:
	asl r13,r16,0x14
L_8cfe7c:
	and r1,r1,0xff0fffff
L_8cfe84:
	or_s r13,r13,r1
L_8cfe86:
	st_s r13,[r0]
L_8cfe88:
	b L_8c0244
	.global L_8cfe8c
L_8cfe8c:
	mov_s r0,blink
L_8cfe8e:
	mov_s r1,0x112b
L_8cfe94:
	bl L_8c9b28
L_8cfe98:
	b_s L_8cfe6a
L_8cfe9a:
	nop_s
